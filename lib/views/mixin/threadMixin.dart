import 'dart:convert';
import 'dart:io';

import 'package:document_scanner/model/thread.dart';
import 'package:document_scanner/provider/provider_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdfx/pdfx.dart';

import '../../ui.dart';
import '../widgets/mixins.dart';

mixin ThreadMixin<T extends StatefulWidget> on StateMixin<T> {
  String? output;
  bool isProcessing = false;
  PlatformFile? file;

  String base64Image = '';
  Uint8List? image;

  void listenThread() {
    try {
      context.appViewModel.listenThread();
    } catch (e) {
      showSnack(e.toString());
    }
  }

  Future<void> getThread({required String id}) async {
    try {
      await context.appViewModel.getThread(id: id);
    } catch (e) {
      showSnack(e.toString());
    }
  }

  Future<void> createThread({required Thread thread}) async {
    try {
      //var go = context.go;
      await context.appViewModel.createThread(thread: thread);
      //go(TranscriptionPageRoute(chatId: id).location);
    } catch (e) {
      showSnack(e.toString());
    }
  }

  Future<void> updateThread({required Thread thread}) async {
    try {
      await context.appViewModel.updateThread(thread: thread);
      showSnack('updated Chat Successfully');
    } catch (e) {
      showSnack(e.toString());
    }
  }

  Future<void> deleteThread({required String id}) async {
    try {
      await context.appViewModel.deleteThread(id: id);
      showSnack('Deleted Chat Successfully');
    } catch (e) {
      showSnack(e.toString());
    }
  }

  Future<void> clearThread() async {
    try {
      await context.appViewModel.clearThread();
      showSnack('Chat Cleared');
    } catch (e) {
      showSnack(e.toString());
    }
  }

  Future<void> pickFile() async {
    // List<int>? fileBytes;
    setState(() {
      isProcessing = true;
    });
    if (file == null) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: [
          'jpeg',
          'pdf',
        ],
      );
      if (result != null) {
        // int fileLength = result.files.length ?? 0;
        //for (int i = 0; i < fileLength; i++) {
        file = result.files.first;
        setState(() {});
        // file = result.files.singleOrNull;
        if (file?.extension == 'pdf') {
          if (file?.path != null) {
            final document = await PdfDocument.openFile(file!.path!);
            image = File(document.toString()).readAsBytesSync();
            setState(() {});
            //   int fileLength = result.files.length ?? 0;
            //   for (int i = 0; i < fileLength; i++) {
            // final page = await document.getPage(1);
            //
            //   final PdfPageImage? i = await page.render(
            //     width: page.width * 2, //decrement for less quality
            //     height: page.height * 2,
            //     format: PdfPageImageFormat.jpeg,
            //     backgroundColor: '#ffffff',
            //   );
            //   image = i?.bytes;
            //   setState(() {});
            // }
          }
        } else {
          image = File(file?.path ?? '').readAsBytesSync();
          setState(() {});
        }
        //fileBytes = (image!.toList() + fileBytes!);
        //}
      }
      List<int> imageBytes = image?.map((e) => e).toList() ?? [];
      base64Image = base64Encode(imageBytes);
    }
    setState(() {
      isProcessing = false;
    });
  }

  void onReject() {
    setState(() {
      file = null;
    });
  }

  void clearData() {
    output = '';
    isProcessing = false;
    file = null;
    base64Image = '';
    image = null;
  }

  Future<void> getAIImageToData(String base64Image) async {
    try {
      output = await context.appViewModel.getAIImageToData(base64Image);
      showSnack('AI data extracted');
    } catch (e) {
      showSnack(e.toString());
    }
  }

  Future<void> onAccept() async {
    setLoading();
    await getAIImageToData(base64Image);
    resetLoading();
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
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

  List<String> base64Image = [];

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

  Future<void> pickFiles() async {
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
        file = result.files.first;
        setState(() {});
        if (isPdf(file)) {
          if (file?.path != null) {
            List<Uint8List>? data = await processDocument(file!);
            base64Image = convertToBase64(data ?? <Uint8List>[]);
          }
        } else {
          List<Uint8List> data = processFile(file!);
          base64Image = convertToBase64(data);
        }
      }
    }
    setState(() {
      isProcessing = false;
    });
  }

  Future<List<Uint8List>> getPath(String imagePath) async {}

  File getFile(String path) => File(file?.path ?? '');

  Future<PdfDocument> getDocument(String path) async =>
      await PdfDocument.openFile(file!.path!);

  bool isPdf(PlatformFile? file) => file?.extension == 'pdf';

  List<Uint8List> processFile(PlatformFile file) {
    Uint8List image = getFile(file.path ?? '').readAsBytesSync();
    return [image];
  }

  Future<List<Uint8List>?> processDocument(PlatformFile file) async {
    final document = await getDocument(file.path ?? '');
    final int pages = document.pagesCount;

    for (int j = 1; j <= pages; j++) {
      try {
        final page = await document.getPage(j);

        final PdfPageImage? i = await page.render(
          width: page.width, //decrement for less quality
          height: page.height,
          format: PdfPageImageFormat.jpeg,
        );

        Uint8List? image = i?.bytes;
        page.close();
        setState(() {});
        if (image != null) {
          return [image];
        }
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  List<String> convertToBase64(List<Uint8List> image) {
    List<String> imageList = [];
    for (var i in image) {
      String base64 = base64Encode(i);
      imageList.add(base64);
    }
    return imageList;
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
    base64Image = [];
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

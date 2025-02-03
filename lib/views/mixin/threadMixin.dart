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
  List<String> base64Image = [];
  List<Uint8List> images = [];
  String? path;
  String? name;

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

  Future<List<Uint8List>?> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpeg',
        'pdf',
      ],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      path = file.path;
      name = file.name;
      return getDataForPreview(path!);
    }
    return null;
  }

  Future<List<Uint8List>?> getDataForPreview(String path) async {
    if (isPdf(path)) {
      return await processDocument(path);
    } else {
      return processFile(path);
    }
  }

  Future<List<String>> getDataForAI(String path) async {
    setState(() {
      isProcessing = true;
    });
    List<Uint8List>? data = await getDataForPreview(path);
    base64Image = convertToBase64(data!);
    setState(() {
      isProcessing = false;
    });
    return base64Image;
  }

  File getFile(String path) => File(path);

  Future<PdfDocument> getDocument(String path) async =>
      await PdfDocument.openFile(path);

  bool isPdf(String path) => path.endsWith('pdf');

  List<Uint8List> processFile(String path) {
    Uint8List image = getFile(path).readAsBytesSync();
    return [image];
  }

  Future<List<Uint8List>?> processDocument(String path) async {
    final document = await getDocument(path);
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
          images.add(image);
        }
      } catch (e) {
        print(e);
      }
    }
    return images;
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
    setState(() {});
  }

  void clearData() {
    output = '';
    isProcessing = false;
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
    for (String base64 in base64Image) {
      await getAIImageToData(base64);
    }
    resetLoading();
  }
}

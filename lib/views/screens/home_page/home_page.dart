import 'dart:convert';
import 'dart:io';
import 'package:built_collection/built_collection.dart';
import 'package:document_scanner/provider/provider_utils.dart';
import 'package:document_scanner/views/components/Threads.dart';
import 'package:document_scanner/views/mixin/threadMixin.dart';
import 'package:document_scanner/views/screens/home_page/pick_file_widget.dart';
import 'package:document_scanner/views/screens/home_page/preview_buttons.dart';
import 'package:document_scanner/views/widgets/mixins.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../widgets/app_markdown.dart';
import 'ai_meta_data.dart';
import 'file_viewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with StateMixin, ThreadMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  // Uint8List? _image;

  // PlatformFile? file;
  // bool isProcessing = false;
  // String base64Image = '';
  String? output;

  // Future<void> pickFile() async {
  //   setState(() {
  //     isProcessing = true;
  //   });
  //   if (file == null) {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       allowMultiple: true,
  //       type: FileType.custom,
  //       allowedExtensions: [
  //         'jpeg',
  //         'pdf',
  //       ],
  //     );
  //     if (result != null) {
  //       file = result.files.first;
  //       setState(() {});
  //       if (file?.extension == 'pdf') {
  //         if (file?.path != null) {
  //           final document = await PdfDocument.openFile(file!.path!);
  //
  //           final page = await document.getPage(1);
  //
  //           final PdfPageImage? i = await page.render(
  //             width: page.width * 2, //decrement for less quality
  //             height: page.height * 2,
  //             format: PdfPageImageFormat.jpeg,
  //             backgroundColor: '#ffffff',
  //           );
  //           //_image = i?.bytes;
  //           _image = (i?.bytes);
  //           setState(() {});
  //           //print(_image);
  //         }
  //       } else {
  //         _image = File(file?.path ?? '').readAsBytesSync();
  //         setState(() {});
  //         // print(_image);
  //       }
  //     }
  //     var imageBytes = _image?.map((e) => e).toList() ?? [];
  //     base64Image = base64Encode(imageBytes);
  //   }
  //   setState(() {
  //     isProcessing = false;
  //   });
  // }

  void onReject() {
    setState(() {
      file = null;
    });
  }

  Future<void> onAccept() async {
    setState(() {
      isProcessing = true;
    });
    await getAIImageToData(base64Image);
    setState(() {
      isProcessing = false;
    });
  }

  Future<String?> getAIImageToData(String base64Image) async {
    final response = await http.post(
      Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
      headers: {
        'Authorization':
            'Bearer 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',
      },
      body: jsonEncode({
        "messages": [
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text":
                    "Extract all the text from the provided image, including handwritten or printed text, numbers, and special characters. Return the content only in proper markdown format, without any additional explanations or identifiers.",
              },
              {
                "type": "image_url",
                "image_url": {"url": "data:image/jpeg;base64,$base64Image"}
              }
            ]
          }
        ],
        "model": "llama-3.2-11b-vision-preview",
        "temperature": 1,
        "max_completion_tokens": 1024,
        "top_p": 1,
        "stream": false,
        "stop": null
      }),
    );

    var jsonDecode2 = jsonDecode(response.body);
    List body = jsonDecode2["choices"];
    var b = body;

    for (var i in b) {
      output = (output ?? '') + (i["message"]["content"]).toString();
    }
    print('Extracted data => $output');
    return null;
  }

  @override
  Widget build(BuildContext context) {
    bool showFilePicker = file == null && !isProcessing;
    bool showPreview = file != null && output == null && !isProcessing;
    bool showProgressIndicator = isProcessing;
    bool showAIResponse = output != null;

    bool showThread = file == null;
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.deepPurple,
        ),
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Document Scanner '),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: showFilePicker
            ? PickFileWidget(
                pickFile: pickFile,
              )
            : null,
        body: showThread
            ? Threads()
            : showProgressIndicator
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if (showPreview) ...[
                            FileViewer(
                              image: image,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            PreviewButtons(
                              onAccept: onAccept,
                              onReject: onReject,
                            ),
                          ],
                          if (showAIResponse)
                            AIMetaData(
                              output: output,

                            )
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}

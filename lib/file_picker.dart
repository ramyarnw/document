import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_to_image_converter/pdf_to_image_converter.dart';

enum Status { initial, proceed, data }

class FilePickerDemo extends StatefulWidget {
  const FilePickerDemo({super.key});

  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  final PdfImageConverter _converter = PdfImageConverter();
  Uint8List? _image;

  Status currentStatus = Status.initial;

  void setCurrentStatus(Status s) {
    currentStatus = s;
    setState(() {});
  }

  File? file;
  bool isProcessing = false;
  String base64Image = '';
  String? output;

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickFile() async {
    if (file == null) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'pdf',
        ],
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        print(file.extension);
        print(file.path);

        if (file.extension == 'pdf') {
          if (file.path != null) {
            await _converter.openPdf(file.path!);
            _image = await _converter.renderPage(0);
          }
        }
      }
      var imageBytes = _image?.map((e) => e).toList() ?? [];
      base64Image = base64Encode(imageBytes);
      setState(() {
        isProcessing = false;
      });
    }
  }

  void onReject() {
    setState(() {
      file = null;
    });
  }

  void onAccept() {
    setState(() {
      isProcessing = true;
    });
    getAIImageToData(base64Image);
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
                    "Extract all the text from the provided image, including handwritten or printed text, numbers, and special characters. Return the content only, without any additional explanations or identifiers.",
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
    var body = jsonDecode2["choices"];
    var b = (body as List);

    for (var i in b) {
      output = (output ?? '') + (i["message"]["content"]).toString();
    }
    print(output);
  }

  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 200.0, bottom: 20.0),
                  child: Center(
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: <Widget>[
                        if (file == null) PickFile(pickFile: pickFile),
                        if (file != null)
                          PreviewFile(
                            onAccept: onAccept,
                            onReject: onReject,
                          ),
                        if(isProcessing)
                          CircularProgressIndicator(),
                        if (output != null) Text('data : $output'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PickFile extends StatelessWidget {
  const PickFile({
    super.key,
    required this.pickFile,
  });

  final void Function() pickFile;

  @override
  Widget build(BuildContext context) {
    late bool isProcessing;

    return SizedBox(
      width: 120,
      child: FloatingActionButton.extended(
          onPressed: () {
            isProcessing = false;
            pickFile();
          },
          label: Text('Pick files'),
          icon: const Icon(Icons.description)),
    );
  }
}

class PreviewFile extends StatelessWidget {
  const PreviewFile({
    super.key,
    this.image,
    required this.onAccept,
    required this.onReject,
  });

  final File? image;

  final void Function() onAccept;
  final void Function() onReject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Preview:'),
        if (image != null)
          Image(
            image: FileImage(image!),
            height: 450,
          ),
        Row(
          children: [
            SizedBox(
              width: 50,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                onAccept();
              },
              label: const Text('Accept'),
              icon: const Icon(Icons.save),
            ),
            SizedBox(
              width: 50,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                onReject();
              },
              label: const Text('Reject'),
              icon: const Icon(Icons.delete_forever),
            )
          ],
        ),
      ],
    );
  }
}

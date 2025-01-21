import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_to_image_converter/pdf_to_image_converter.dart';

import 'models/message.dart';

enum Status { initial, proceed, data }

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _defaultFileNameController = TextEditingController();
  final _dialogTitleController = TextEditingController();
  final _initialDirectoryController = TextEditingController();
  final _fileExtensionController = TextEditingController();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _lockParentWindow = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  final PdfImageConverter _converter = PdfImageConverter();
  Uint8List? _image;

  bool showFile = false;
  bool close = false;

  bool showData = false;

  Status currentStatus = Status.initial;

  void setCurrentStatus(Status s) {
    currentStatus = s;
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    _fileExtensionController
        .addListener(() => _extension = _fileExtensionController.text);
  }

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        compressionQuality: 30,
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        dialogTitle: _dialogTitleController.text,
        initialDirectory: _initialDirectoryController.text,
        lockParentWindow: _lockParentWindow,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }

  void _clearCachedFiles() async {
    _resetState();
    try {
      bool? result = await FilePicker.platform.clearTemporaryFiles();
      _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            (result!
                ? 'Temporary files removed with success.'
                : 'Failed to clean temporary files'),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String? base64Image;
  String content = '';

  Future<void> groq() async {
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
      content += (i["message"]["content"]).toString();
    }
    setCurrentStatus(Status.data);
    print(content);
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  Future<void> selectPdf() async {
    final String path =
        '/Users/ramya/IdeaProjects/document_scanner/assets/pdf/dummy.pdf';
    //final path = await PdfPicker.pickPdf();
    if (path != null) {
      await _converter.openPdf(path);
      _image = await _converter.renderPage(0);
      var imageBytes = _image?.map((e) => e).toList() ?? [];
      base64Image = base64Encode(imageBytes);
      //print('base64Image => $base64Image');
      setCurrentStatus(Status.proceed);
      setState(() {});
    }
  }

  void imageClose() {
    _image = null;
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
                        if (currentStatus == Status.initial)
                          PickFile(selectPdf: selectPdf),
                        if (currentStatus == Status.proceed)
                          ImagePreview(
                            groq: groq,
                            image: _image,
                          ),
                        if (currentStatus == Status.data)
                          Text('Data : $content'),
                      ],
                    ),
                  ),
                ),
                if (currentStatus == Status.proceed) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton.icon(
                        onPressed: _converter.currentPage > 0
                            ? () async {
                                _image = await _converter
                                    .renderPage(_converter.currentPage - 1);
                                setState(() {});
                              }
                            : null,
                        icon: const Icon(Icons.chevron_left),
                        label: const Text('Previous'),
                      ),
                      TextButton.icon(
                        onPressed:
                            _converter.currentPage < (_converter.pageCount - 1)
                                ? () async {
                                    _image = await _converter
                                        .renderPage(_converter.currentPage + 1);
                                    setState(() {});
                                  }
                                : null,
                        icon: const Icon(Icons.chevron_right),
                        label: const Text('Next'),
                      ),
                    ],
                  ),
                ],
                const SizedBox(
                  height: 500,
                ),
                Builder(
                  builder: (BuildContext context) => _isLoading
                      ? Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 40.0,
                                  ),
                                  child: const CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ],
                        )
                      : _userAborted
                          ? Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: SizedBox(
                                      width: 300,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.error_outline,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 40.0),
                                        title: const Text(
                                          'User has aborted the dialog',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : _directoryPath != null
                              ? ListTile(
                                  title: const Text('Directory path'),
                                  subtitle: Text(_directoryPath!),
                                )
                              : _paths != null
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20.0,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.50,
                                      child: Scrollbar(
                                          child: ListView.separated(
                                        itemCount:
                                            _paths != null && _paths!.isNotEmpty
                                                ? _paths!.length
                                                : 1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final bool isMultiPath =
                                              _paths != null &&
                                                  _paths!.isNotEmpty;
                                          final String name =
                                              'File $index: ${isMultiPath ? _paths!.map((e) => e.name).toList()[index] : _fileName ?? '...'}';
                                          final path = kIsWeb
                                              ? null
                                              : _paths!
                                                  .map((e) => e.path)
                                                  .toList()[index]
                                                  .toString();

                                          return ListTile(
                                            title: Text(
                                              name,
                                            ),
                                            subtitle: Text(path ?? ''),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Divider(),
                                      )),
                                    )
                                  : _saveAsFileName != null
                                      ? ListTile(
                                          title: const Text('Save file'),
                                          subtitle: Text(_saveAsFileName!),
                                        )
                                      : const SizedBox(),
                ),
                SizedBox(
                  height: 40.0,
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
    required this.selectPdf,
  });

  final void Function() selectPdf;

  @override
  Widget build(BuildContext context) {
    bool showFile = false;
    bool _multiPick = false;

    return SizedBox(
      width: 120,
      child: FloatingActionButton.extended(
          onPressed: () {
            selectPdf();
            showFile = true;
          },
          label: Text(_multiPick ? 'Pick files' : 'Pick file'),
          icon: const Icon(Icons.description)),
    );
  }
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.groq, this.image,});

  final void Function() groq;
  final Uint8List? image;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const Text('Preview:'),
        if (image != null)
          Image(
            image: MemoryImage(image!),
            height: 450,
          ),
        Row(
          children: [
            SizedBox(
              width: 50,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                groq();
              },
              label: const Text('Proceed'),
              icon: const Icon(Icons.save),
            ),
            SizedBox(
              width: 50,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                //set null
              },
              label: const Text('Cancel'),
              icon: const Icon(Icons.delete_forever),
            )
          ],
        ),
      ],
    );
  }
}

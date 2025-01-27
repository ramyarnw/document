import 'dart:convert';
import 'dart:io';
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
import '../../widgets/app_texts.dart';
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
                              imageData: image,
                              file: file,
                            )
                        ],
                      ),
                    ),
                  ),
        // persistentFooterButtons: [
        //   ElevatedButton(
        //     onPressed: () async {
        //       isLoading = true;
        //       refresh();
        //       await _createThread();
        //       clearData();
        //       isLoading = false;
        //       refresh();
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => HomePage(),
        //         ),
        //       );
        //     },
        //     child: AppText(
        //       'Save',
        //     ),
        //   ),
        //
        // ],
      ),
    );
  }
}

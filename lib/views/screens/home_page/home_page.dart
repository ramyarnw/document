import 'dart:convert';
import 'dart:io';
import 'package:built_collection/built_collection.dart';
import 'package:document_scanner/views/components/Threads.dart';
import 'package:document_scanner/views/mixin/threadMixin.dart';
import 'package:document_scanner/views/screens/home_page/pick_file_widget.dart';
import 'package:document_scanner/views/screens/home_page/preview_buttons.dart';
import 'package:document_scanner/views/widgets/mixins.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../../model/thread.dart';
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

  Future<void> _createThread() async {
    //final BuiltList<int> image = File(file?.path ?? '').readAsBytesSync().toBuiltList();
    final BuiltList<int>? i = image?.toBuiltList();
    Thread thread = Thread(
      (t) => t
        ..id = ''
        ..image = i?.toBuilder()
        ..aiData = output
        ..fileName = file?.name ?? '',
    );
    await createThread(thread: thread);
  }

  bool isLoading = false;

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
      home: ScaffoldMessenger(
        child: Scaffold(
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
                        ],
                        if (showAIResponse)
                          AIMetaData(
                            output: output,
                            //imageData: image,
                            file: file,
                          )
                      ],
                    ),
                  ),
                ),
          persistentFooterButtons: [
            if (output != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: () async {
                  isLoading = true;
                  refresh();
                  await _createThread();
                  clearData();
                  isLoading = false;
                  refresh();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: isLoading
                    ? CircularProgressIndicator()
                    : Center(
                        child: AppText(
                          'Save',
                        ),
                      ),
              ),
            if ((image != null) && (!isProcessing) && (output == null))
              PreviewButtons(onAccept: onAccept, onReject: onReject, isProcessing: loading,)
          ],
        ),
      ),
    );
  }
}

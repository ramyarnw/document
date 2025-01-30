import 'package:built_collection/built_collection.dart';
import 'package:document_scanner/views/components/Threads.dart';
import 'package:document_scanner/views/mixin/threadMixin.dart';
import 'package:document_scanner/views/screens/home_page/pick_file_widget.dart';
import 'package:document_scanner/views/screens/home_page/preview_buttons.dart';
import 'package:document_scanner/views/widgets/app_bar.dart';
import 'package:document_scanner/views/widgets/mixins.dart';
import 'package:flutter/material.dart';

import '../../../model/thread.dart';
import '../../widgets/app_progress_indicator.dart';
import '../../widgets/app_scaffold.dart';
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
    Thread thread = Thread(
      (t) => t
        ..id = ''
        ..imagePath = file?.path ?? ''
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
    bool showSaveButton = output != null;
    bool showAIResponse = showSaveButton;
    bool showThread = file == null;
    bool showPreviewButton = (image != null) && (!isProcessing) && (output == null);
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
        child: AppScaffold(
          key: _scaffoldKey,
          appBar: ApplicationAppBar(
            title: const AppBoldHeader('Document Scanner '),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: showFilePicker
              ? PickFileWidget(
                  pickFile: pickFiles,
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
                            file: file,
                          ),
                      ],
                    ),
                  ),
                ),
          persistentFooterButtons: [
            if (showSaveButton)
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
                    ? AppProgressIndicator(size: 12,color: Colors.white, width: 2,)
                    : Center(
                        child: AppText(
                          'Save',
                        ),
                      ),
              ),
            if (showPreviewButton)
              PreviewButtons(onAccept: onAccept, onReject: onReject, isProcessing: loading,),
          ],
        ),
      ),
    );
  }
}

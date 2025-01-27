import 'package:built_collection/built_collection.dart';
import 'package:document_scanner/views/screens/home_page/file_viewer.dart';
import 'package:document_scanner/views/widgets/app_markdown.dart';
import 'package:document_scanner/views/widgets/extensions.dart';
import 'package:file_picker/file_picker.dart';

import '../../../model/thread.dart';
import '../../../ui.dart';
import '../../mixin/threadMixin.dart';
import '../../widgets/app_texts.dart';
import '../../widgets/mixins.dart';
import 'home_page.dart';

class AIMetaData extends StatefulWidget {
  const AIMetaData({
    super.key,
    this.output,
    this.file,
  });

  final String? output;
  final PlatformFile? file;

  @override
  State<AIMetaData> createState() => _AIMetaDataState();
}

class _AIMetaDataState extends State<AIMetaData> with StateMixin, ThreadMixin {
  Future<void> _createThread() async {
    final BuiltList<int>? image = widget.file?.bytes?.toBuiltList();
    Thread thread = Thread(
      (t) => t
        ..id = ''
        ..image = image?.toBuilder()
        ..aiData = widget.output
        ..fileName = widget.file?.name ?? '',
    );
    await createThread(thread: thread);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var showSave = widget.file != null;
    print('save => $showSave');
    return Column(
      children: [
        if (widget.file != null) ...[
          FileViewer(
            image: widget.file?.bytes,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
        SizedBox(
          width: size.width,
          height: size.height * 0.8,
          child: AppMarkdown(
            text: widget.output ?? '',
            // text: widget.output ?? '',
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        if(showSave)
        ElevatedButton(
          onPressed: () async {
            isLoading = true;
            refresh();
            await _createThread();
            isLoading = false;
            refresh();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: AppText(
            'Save',
          ),
        ),
      ],
    );
  }
}

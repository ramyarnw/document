import 'package:built_collection/built_collection.dart';
import 'package:file_picker/file_picker.dart';

import '../../../model/thread.dart';
import '../../../ui.dart';
import '../../mixin/threadMixin.dart';
import '../../widgets/app_markdown.dart';
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
  void _createThread() {
    final BuiltList<int>? image = widget.file?.bytes?.toBuiltList();
    Thread thread = Thread(
      (t) => t
        ..image = image?.toBuilder()
        ..aiData = widget.output,
    );
    createThread(thread: thread);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppMarkdown(
          text: widget.output ?? '',
        ),
        ElevatedButton(
          onPressed: () {
            isLoading = true;
            refresh();
            _createThread();
            isLoading = false;
            refresh();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const HomePage();
                },
              ),
            );
          },
          child: AppText('Save'),
        ),
      ],
    );
  }
}

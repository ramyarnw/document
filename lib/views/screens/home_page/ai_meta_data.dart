import 'package:built_collection/built_collection.dart';
import 'package:document_scanner/views/navigation/app_routes.dart';
import 'package:document_scanner/views/navigation/router_utils.dart';
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
  Future<void> _createThread() async {
    final BuiltList<int>? image = widget.file?.bytes?.toBuiltList();
    Thread thread = Thread(
      (t) => t
        ..image = image?.toBuilder()
        ..aiData = widget.output,
    );
    await createThread(thread: thread);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            widget.output ?? '',
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () async {
            var go = context.go;
            isLoading = true;
            refresh();
            await _createThread();
            isLoading = false;
            refresh();
            go(HomePageRoute().location);
          },
          child: AppText(
            'Save',
          ),
        ),
      ],
    );
  }
}

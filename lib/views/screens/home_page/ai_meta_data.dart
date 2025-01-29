import 'package:document_scanner/views/screens/home_page/file_viewer.dart';
import 'package:document_scanner/views/widgets/app_markdown.dart';
import 'package:file_picker/file_picker.dart';

import '../../../ui.dart';
import '../../mixin/threadMixin.dart';
import '../../widgets/mixins.dart';

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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        if (widget.file != null) ...[
          FileViewer(
            imageList: widget.file?.bytes, imagePath: widget.file.path,
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
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

import 'package:document_scanner/views/mixin/threadMixin.dart';
import 'package:document_scanner/views/widgets/mixins.dart';

import '../../../ui.dart';

class FileViewer extends StatefulWidget {
  const FileViewer({
    super.key,
    this.image,
  });

  final Uint8List? image;

  @override
  State<FileViewer> createState() => _FileViewerState();
}

class _FileViewerState extends State<FileViewer>with StateMixin, ThreadMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.image != null) {
      Image image = Image.memory(
            widget.image!,
          );
      return SizedBox(
        height: 600,
        child: Center(
          child: image,
        ),
      );
    }
    return Container();
  }
}

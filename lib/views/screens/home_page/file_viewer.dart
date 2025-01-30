import 'dart:typed_data';

import 'package:document_scanner/ui.dart';
import 'package:document_scanner/views/mixin/threadMixin.dart';
import 'package:document_scanner/views/widgets/mixins.dart';

import '../../../model/thread.dart';
import '../../../ui.dart';

class FileViewer extends StatefulWidget {
  const FileViewer({
    super.key,
    required this.getDataForPreview,
  });

  final Future<List<Uint8List>?> Function() getDataForPreview;

  @override
  State<FileViewer> createState() => _FileViewerState();
}

class _FileViewerState extends State<FileViewer> with StateMixin, ThreadMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Center(
        child: ListView.builder(
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                image: images[index],
              );
            }),
      ),
    );
      return Container();
  }
}
class ListTile extends StatefulWidget {
  const ListTile({super.key, required this.image,});
final Uint8List image;
  @override
  State<ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<ListTile>with StateMixin,ThreadMixin {
  @override
  Widget build(BuildContext context) {
    return Image.memory(widget.image);
  }
}

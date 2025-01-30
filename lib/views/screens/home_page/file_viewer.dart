
import 'dart:typed_data';

import 'package:document_scanner/ui.dart';
import 'package:document_scanner/views/mixin/threadMixin.dart';
import 'package:document_scanner/views/widgets/mixins.dart';

import '../../../ui.dart';

class FileViewer extends StatefulWidget {
  const FileViewer({
    super.key, required this.imageList, required this.base64Image,
  });

  //final Uint8List? image;
  final List<String>? imageList;
  final List<String> base64Image;


  @override
  State<FileViewer> createState() => _FileViewerState();
}

class _FileViewerState extends State<FileViewer>with StateMixin, ThreadMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.imageList != null) {
     // Uint8List fromList = Uint8List.fromList(widget.imageList!.cast<int>());
      Image image = Image.memory(
           base64Image
          );
      return SizedBox(
        height: 600,
        child: Center(
          child: ListView.builder(
              itemCount: base64Image.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: image,
                );
              }),
        ),
      );
    }
    return Container();
  }
}

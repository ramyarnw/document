import 'package:document_scanner/ui.dart';
import 'package:document_scanner/views/mixin/threadMixin.dart';
import 'package:document_scanner/views/widgets/app_progress_indicator.dart';
import 'package:document_scanner/views/widgets/mixins.dart';

class FileViewer extends StatefulWidget {
  const FileViewer({
    super.key,
    required this.path,
  });

  final String path;

  @override
  State<FileViewer> createState() => _FileViewerState();
}

List<Uint8List>? imageList;

class _FileViewerState extends State<FileViewer> with StateMixin, ThreadMixin {
  @override
  Future<void> initState() async {
    super.initState();
    setLoading();
    imageList = await getDataForPreview(widget.path).then((_) {
      resetLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: loading
          ? const AppProgressIndicator(width: 56)
          : ListView.builder(
              itemCount: imageList?.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  image: imageList![index],
                );
              }),
    );
    return Container();
  }
}

class ListTile extends StatefulWidget {
  const ListTile({
    super.key,
    required this.image,
  });

  final Uint8List image;

  @override
  State<ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<ListTile> with StateMixin, ThreadMixin {
  @override
  Widget build(BuildContext context) {
    return Image.memory(widget.image);
  }
}

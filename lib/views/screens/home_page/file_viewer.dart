import 'package:document_scanner/ui.dart';
import 'package:document_scanner/views/mixin/threadMixin.dart';
import 'package:document_scanner/views/widgets/app_progress_indicator.dart';
import 'package:document_scanner/views/widgets/mixins.dart';

class FileViewer extends StatefulWidget {
  const FileViewer({
    super.key,
    required this.path,
    required this.getDataForPreview,
  });

  final String path;
  final Future<List<Uint8List>?> Function(String path) getDataForPreview;

  @override
  State<FileViewer> createState() => _FileViewerState();
}

class _FileViewerState extends State<FileViewer> with StateMixin {
  List<Uint8List>? imageList;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setLoading();
    imageList = await widget.getDataForPreview(widget.path);
    resetLoading();
  }

  @override
  Widget build(BuildContext context) {
    var hasImages = (imageList == null) || (imageList?.isEmpty ?? false);
    print('imageList: $imageList, hasImages: $hasImages');
    return SizedBox(
      height: 600,
      child: loading
          ? const AppProgressIndicator(width: 56)
          : hasImages
              ? Container()
              : ListView.builder(
                  itemCount: imageList!.length,
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

import 'package:document_scanner/views/screens/home_page/file_viewer.dart';
import 'package:document_scanner/views/widgets/app_markdown.dart';

import '../../../ui.dart';
import '../../widgets/mixins.dart';

class AIMetaData extends StatefulWidget {
  const AIMetaData({
    super.key,
    this.output, required this.path, required this.getDataForAI, required this.getDataForPreview,
  });

  final String? output;
  final String path;
  final Future<List<String>> Function(String path)getDataForAI;
  final Future<List<Uint8List>?> Function(String path) getDataForPreview;


  @override
  State<AIMetaData> createState() => _AIMetaDataState();
}

class _AIMetaDataState extends State<AIMetaData> with StateMixin {
  List<String>? base64List;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setLoading();
    base64List = await widget.getDataForAI(widget.path);

    resetLoading();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Column(
      children: [
        ...[
          FileViewer(
            path: widget.path, getDataForPreview: widget.getDataForPreview
          ,),
          const SizedBox(
            height: 16,
          ),
        ],
        SizedBox(
          width: size.width,
          height: size.height * 0.8,
          child: AppMarkdown(
            text:base64List!=null?base64List!.map((a) =>a).join(''):'',
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

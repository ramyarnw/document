import 'package:document_scanner/provider/provider_utils.dart';
import 'package:document_scanner/views/mixin/threadMixin.dart';
import 'package:document_scanner/views/widgets/app_scaffold.dart';
import 'package:document_scanner/views/widgets/app_texts.dart';
import 'package:document_scanner/views/widgets/mixins.dart';

import '../../model/thread.dart';
import '../../ui.dart';
import '../widgets/app_bar.dart';
import 'home_page/ai_meta_data.dart';
import 'home_page/file_viewer.dart';

class ThreadPage extends StatefulWidget {
  final String id;

  const ThreadPage({
    super.key,
    required this.id,
  });

  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> with StateMixin, ThreadMixin {
  List<Uint8List>? imageList;
  List<String>? base64List;
  Thread? thread;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setLoading();
    thread = context.appViewModel.getState().getThreadById(widget.id);
    String? path = thread?.imagePath;
    imageList = await getDataForPreview(path ?? '');
    base64List = await getDataForAI(path ?? '');
    resetLoading();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return AppScaffold(
      appBar: ApplicationAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppSubtitle(thread?.fileName ?? 'Preview'),
          ],
        ),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: loading
              ? CircularProgressIndicator()
              : Column(
                  children: [
                    FileViewer(
                      path: path ?? '',
                      getDataForPreview: (String path) async {},
                    ),
                    AIMetaData(
                      output: thread?.aiData,
                      path: path ?? '',
                      getDataForAI: getDataForAI,
                      getDataForPreview: getDataForPreview,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

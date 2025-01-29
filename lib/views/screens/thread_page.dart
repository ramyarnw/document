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
  @override
  Widget build(BuildContext context) {
    Thread? thread = context.appState.getThreadById(widget.id);
    final Uint8List _image = Uint8List.fromList(thread?.image.toList() ?? []);
    print('Preview img: $_image');
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return AppScaffold(
      appBar: ApplicationAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppHeader(thread?.fileName ?? 'Preview'),
          ],
        ),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FileViewer(
                imageList: _image,
              ),
              AIMetaData(
                output: thread?.aiData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

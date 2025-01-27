import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:document_scanner/views/screens/home_page/file_viewer.dart';
import 'package:document_scanner/views/widgets/app_markdown.dart';
import 'package:document_scanner/views/widgets/app_scaffold.dart';
import 'package:document_scanner/views/widgets/extensions.dart';
import 'package:file_picker/file_picker.dart';

import '../../../model/thread.dart';
import '../../../ui.dart';
import '../../mixin/threadMixin.dart';
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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //var showSave = widget.file != null;
    return Column(
      children: [
        if (widget.file != null) ...[
          FileViewer(
            image: widget.file?.bytes,
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
        //if (showSave)
          // ElevatedButton(
          //   onPressed: () async {
          //     isLoading = true;
          //     refresh();
          //     await _createThread();
          //     clearData();
          //     isLoading = false;
          //     refresh();
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => HomePage(),
          //       ),
          //     );
          //   },
          //   child: AppText(
          //     'Save',
          //   ),
          // ),
      ],
    );
  }
}

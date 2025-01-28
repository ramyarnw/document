import 'package:built_collection/src/list.dart';
import 'package:document_scanner/provider/provider_utils.dart';
import 'package:document_scanner/utils/extensions.dart';
import 'package:document_scanner/views/mixin/threadMixin.dart';
import 'package:document_scanner/views/navigation/router_utils.dart';
import 'package:document_scanner/views/screens/thread_page.dart';
import 'package:file_picker/file_picker.dart';

import '../../model/thread.dart';
import '../../ui.dart';
import '../navigation/app_routes.dart';
import '../widgets/app_bar.dart';
import '../widgets/app_icon.dart';
import '../widgets/app_progress_indicator.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/app_texts.dart';
import '../widgets/mixins.dart';

class Threads extends StatefulWidget {
  const Threads({
    super.key,
  });

  @override
  State<Threads> createState() => _ThreadsState();
}

class _ThreadsState extends State<Threads> with StateMixin, ThreadMixin {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setLoading();
    listenThread();
    resetLoading();
  }

  @override
  Widget build(BuildContext context) {
    final BuiltList<Thread> threads = context.appState.threads;
    return AppScaffold(
      appBar: ApplicationAppBar(
        title: AppBoldTitle(
          'Threads',
        ),
      ),
      body: loading
          ? const Center(
              child: AppProgressIndicator(
                size: 12,
                color: Colors.white,
                width: 12,
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
              child: threads.isEmpty
                  ? const Center(
                      child: AppSubtitle('No Threads'),
                    )
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: threads.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ThreadTile(
                          thread: threads[index],
                        );
                      }),
            ),
    );
  }
}

class ThreadTile extends StatefulWidget {
  const ThreadTile({
    super.key,
    required this.thread,
    this.file,
  });

  final Thread thread;
  final PlatformFile? file;

  @override
  State<ThreadTile> createState() => _ThreadTileState();
}

class _ThreadTileState extends State<ThreadTile> with StateMixin, ThreadMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: InkWell(
        child: Row(
          children: [
            AppIcon(
              icons.file,
            ),
            const SizedBox(
              width: 20,
            ),
            AppTitle(widget.thread.fileName ?? ''),
            Spacer(),
            InkWell(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteAlertBox(
                      deleteThread: deleteThread,
                      id: widget.thread.id,
                    );
                  },
                );
              },
              child: AppIcon(icons.delete),
            ),
          ],
        ),
        onTap: () {
          context.push(ThreadPageRoute(threadId: widget.thread.id).location);
        },
      ),
    );
  }
}

class DeleteAlertBox extends StatelessWidget {
  const DeleteAlertBox(
      {super.key, required this.deleteThread, required this.id});

  final Future<void> Function({required String id}) deleteThread;
  final String id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          AppTitle(
            'Are you Sure Want To Delete The File',
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    deleteThread(id: id);
                    Navigator.pop(context);
                  },
                  child: AppSubtitle('Delete')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: AppSubtitle('Cancel')),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:built_collection/built_collection.dart';
import 'package:document_scanner/model/thread.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

import '../core/services/local_sore_service.dart';
import '../core/view_model/view_model.dart';
import '../data/repository.dart';
import '../model/app_state.dart';
import '../provider/app_state_notifier.dart';
import '../ui.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, this.child, required this.repo});

  final Widget? child;
  final AppRepository repo;

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<AppViewModel, AppState>(
      create: (_) => AppViewModel(repo),
      child: child,
    );
  }
}

class AppViewModel extends AppStateNotifier<AppState>
    implements AppBaseViewModel {
  AppViewModel(this._repo) : super(AppState());

  final AppRepository _repo;
  LocalStoreService get localStoreService => _repo.localStoreService;


  @override
  Future<void> init() async {
    await _repo.init();
  }

  void decrement() {
    state = state.rebuild((AppStateBuilder b) => b.count = b.count! - 1);
  }

  void increment() {
    state = state.rebuild((AppStateBuilder b) => b.count = b.count! + 1);
  }
  void listenThread()
  {
    localStoreService.listenThread().listen((BuiltList<Thread> c) {
      state = state.rebuild((AppStateBuilder p) => p.threads = c.toBuilder());
    });
  }
  Future<void> getThread({required String id}) async {
    await localStoreService.getThread(id: id);
  }
  Future<void> createThread({required Thread thread}) async {
    await localStoreService.createThread(thread: thread);
  }
  Future<void> updateThread({required Thread thread}) async {
    // final Thread t = thread.rebuild((p) => p.title = thread.title);
    // await localStoreService.updateThread(thread: t);
  }
  Future<void> deleteThread({required String id}) async {
    await localStoreService.deleteThread(id: id);
  }
  Future<void> clearThread() async {
    await localStoreService.clearThread();
  }

}

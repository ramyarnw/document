
import 'package:built_collection/built_collection.dart';

import '../../model/thread.dart';
import 'app_service.dart';

abstract class LocalStoreService extends AppService {
  Stream<BuiltList<Thread>> listenThread();

  Future<Thread> getThread({required String id});

  Future<void> createThread({required Thread thread});

  Future<void> updateThread({required String id});

  Future<void> deleteThread({required String id});

  Future<void> clearThread();
  Future<String?> getAIImageToData(String base64Image);


}

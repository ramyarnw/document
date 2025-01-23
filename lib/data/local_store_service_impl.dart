
import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:localstore/localstore.dart';

import '../core/services/local_sore_service.dart';
import '../model/data.dart';
import '../model/thread.dart';

class LocalStoreServiceImpl implements LocalStoreService {
  Localstore get db => Localstore.instance;

  CollectionRef get threads => db.collection('thread');
  CollectionRef get datas => db.collection('data');


  final StreamController<BuiltList<Thread>> _threadController =
      StreamController<BuiltList<Thread>>.broadcast();

  @override
  Future<void> clearThread() async {
    await threads.delete();
  }

  @override
  Future<void> createThread({required Thread thread}) async {
    final String threadDoc = threads.doc().id;
    final Thread c = thread.rebuild((b) => b.id = threadDoc);
    await threads.doc(threadDoc).set(c.toJson());
    _refreshThread();
  }

  void _refreshThread() {
    threads.get().then((Map<String, dynamic>? data) {
      final BuiltList<Thread> t = (data ?? <String, dynamic>{})
          .values
          .cast<Map<String, dynamic>>()
          .map(Thread.fromJson)
          .toBuiltList();
      _threadController.add(t);
    });
  }

  @override
  Future<void> deleteThread({required String id}) async {
    await threads.doc(id).delete();
    _refreshThread();
  }

  @override
  Future<void> dispose() async {}

  @override
  Future<BuiltList<Data>> getDataForThread({required String threadId}) async{
    final Map<String, dynamic>? data =
    await datas.where('threadId', isEqualTo: threadId).get();
    return (data ?? <String,dynamic>{})
        .values
        .cast<Map<String, dynamic>>()
        .map(Data.fromJson)
        .toBuiltList();
  }

  @override
  Future<Thread> getThread({required String id}) async {
    final Map<String, dynamic>? data = await threads.doc(id).get();
    if (data == null) {
      throw 'thread not available';
    }
    return Thread.fromJson(data);
  }

  @override
  Future<void> init() async {}

  @override
  Stream<BuiltList<Thread>> listenThread() {
    _refreshThread();
     return _threadController.stream;
  }

  @override
  Future<void> updateThread({required String id}) async {}
}

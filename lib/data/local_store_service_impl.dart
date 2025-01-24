import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:localstore/localstore.dart';

import '../core/services/local_sore_service.dart';
import '../model/thread.dart';

class LocalStoreServiceImpl implements LocalStoreService {
  Localstore get db => Localstore.instance;

  CollectionRef get threads => db.collection('thread');

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
  Future<Thread> getThread({required String id}) async {
    final Map<String, dynamic>? data = await threads.doc(id).get();
    if (data == null) {
      throw 'thread not available';
    }
    return  Thread.fromJson(data);
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

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:document_scanner/model/serializers.dart';

part 'thread.g.dart';

abstract class Thread implements Built<Thread, ThreadBuilder> {
  Thread._();

  factory Thread([void Function(ThreadBuilder) updates]) = _$Thread;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Thread.serializer, this)
        as Map<String, dynamic>;
  }

  static Thread fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Thread.serializer, json)!;
  }

  static Serializer<Thread> get serializer => _$threadSerializer;

  static void _initializeBuilder(ThreadBuilder b) {
    b.fileName = '';
  }

  String get id;

  String get imagePath;

  String get aiData;

  String get fileName;
}


import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:document_scanner/model/serializers.dart';
import 'package:document_scanner/model/thread.dart';


part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {


  AppState._();
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(AppState.serializer, this) as Map<String,dynamic>;
  }

  static AppState fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(AppState.serializer, json)!;
  }

  static Serializer<AppState> get serializer => _$appStateSerializer;
  BuiltList<Thread> get threads;
  int? get count;

   Thread? getThreadById(String id) =>
      threads.where(( Thread t)=> t.id == id).firstOrNull;

}
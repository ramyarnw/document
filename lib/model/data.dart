import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:document_scanner/model/serializers.dart';

part 'data.g.dart';

abstract class Data implements Built<Data, DataBuilder> {


  Data._();
  factory Data([void Function(DataBuilder) updates]) = _$Data;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Data.serializer, this)as Map<String,dynamic>;
  }

  static Data fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Data.serializer, json)!;
  }

  static Serializer<Data> get serializer => _$dataSerializer;
  String get aiData;
  String get threadId;
}
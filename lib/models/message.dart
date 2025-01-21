import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:document_scanner/models/serializers.dart';

part 'message.g.dart';

abstract class Message implements Built<Message, MessageBuilder> {


  Message._();
  factory Message([void Function(MessageBuilder) updates]) = _$Message;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Message.serializer, this)as Map<String,dynamic>;
  }

  static Message fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Message.serializer, json)!;
  }

  static Serializer<Message> get serializer => _$messageSerializer;
  String get role;
 BuiltList<Content> get content;
}

abstract class Content implements Built<Content, ContentBuilder> {


  Content._();
  factory Content([void Function(ContentBuilder) updates]) = _$Content;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Content.serializer, this) as Map <String,dynamic>;
  }

  static Content fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Content.serializer, json)!;
  }

  static Serializer<Content> get serializer => _$contentSerializer;
  String get type;
  String? get text;

  ImageUrl? get imageUrl;

}
abstract class ImageUrl implements Built<ImageUrl, ImageUrlBuilder> {


  ImageUrl._();
  factory ImageUrl([void Function(ImageUrlBuilder) updates]) = _$ImageUrl;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ImageUrl.serializer, this) as Map<String,dynamic>;
  }

  static ImageUrl fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ImageUrl.serializer, json)!;
  }

  static Serializer<ImageUrl> get serializer => _$imageUrlSerializer;
  String get url;
}

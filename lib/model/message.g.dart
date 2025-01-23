// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Message> _$messageSerializer = new _$MessageSerializer();
Serializer<Content> _$contentSerializer = new _$ContentSerializer();
Serializer<ImageUrl> _$imageUrlSerializer = new _$ImageUrlSerializer();

class _$MessageSerializer implements StructuredSerializer<Message> {
  @override
  final Iterable<Type> types = const [Message, _$Message];
  @override
  final String wireName = 'Message';

  @override
  Iterable<Object?> serialize(Serializers serializers, Message object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'role',
      serializers.serialize(object.role, specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Content)])),
    ];

    return result;
  }

  @override
  Message deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'role':
          result.role = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'content':
          result.content.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Content)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ContentSerializer implements StructuredSerializer<Content> {
  @override
  final Iterable<Type> types = const [Content, _$Content];
  @override
  final String wireName = 'Content';

  @override
  Iterable<Object?> serialize(Serializers serializers, Content object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.text;
    if (value != null) {
      result
        ..add('text')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ImageUrl)));
    }
    return result;
  }

  @override
  Content deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ContentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'imageUrl':
          result.imageUrl.replace(serializers.deserialize(value,
              specifiedType: const FullType(ImageUrl))! as ImageUrl);
          break;
      }
    }

    return result.build();
  }
}

class _$ImageUrlSerializer implements StructuredSerializer<ImageUrl> {
  @override
  final Iterable<Type> types = const [ImageUrl, _$ImageUrl];
  @override
  final String wireName = 'ImageUrl';

  @override
  Iterable<Object?> serialize(Serializers serializers, ImageUrl object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ImageUrl deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ImageUrlBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Message extends Message {
  @override
  final String role;
  @override
  final BuiltList<Content> content;

  factory _$Message([void Function(MessageBuilder)? updates]) =>
      (new MessageBuilder()..update(updates))._build();

  _$Message._({required this.role, required this.content}) : super._() {
    BuiltValueNullFieldError.checkNotNull(role, r'Message', 'role');
    BuiltValueNullFieldError.checkNotNull(content, r'Message', 'content');
  }

  @override
  Message rebuild(void Function(MessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MessageBuilder toBuilder() => new MessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Message && role == other.role && content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Message')
          ..add('role', role)
          ..add('content', content))
        .toString();
  }
}

class MessageBuilder implements Builder<Message, MessageBuilder> {
  _$Message? _$v;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  ListBuilder<Content>? _content;
  ListBuilder<Content> get content =>
      _$this._content ??= new ListBuilder<Content>();
  set content(ListBuilder<Content>? content) => _$this._content = content;

  MessageBuilder();

  MessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _content = $v.content.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Message other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Message;
  }

  @override
  void update(void Function(MessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Message build() => _build();

  _$Message _build() {
    _$Message _$result;
    try {
      _$result = _$v ??
          new _$Message._(
            role:
                BuiltValueNullFieldError.checkNotNull(role, r'Message', 'role'),
            content: content.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'content';
        content.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Message', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Content extends Content {
  @override
  final String type;
  @override
  final String? text;
  @override
  final ImageUrl? imageUrl;

  factory _$Content([void Function(ContentBuilder)? updates]) =>
      (new ContentBuilder()..update(updates))._build();

  _$Content._({required this.type, this.text, this.imageUrl}) : super._() {
    BuiltValueNullFieldError.checkNotNull(type, r'Content', 'type');
  }

  @override
  Content rebuild(void Function(ContentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ContentBuilder toBuilder() => new ContentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Content &&
        type == other.type &&
        text == other.text &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Content')
          ..add('type', type)
          ..add('text', text)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class ContentBuilder implements Builder<Content, ContentBuilder> {
  _$Content? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  ImageUrlBuilder? _imageUrl;
  ImageUrlBuilder get imageUrl => _$this._imageUrl ??= new ImageUrlBuilder();
  set imageUrl(ImageUrlBuilder? imageUrl) => _$this._imageUrl = imageUrl;

  ContentBuilder();

  ContentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _text = $v.text;
      _imageUrl = $v.imageUrl?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Content other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Content;
  }

  @override
  void update(void Function(ContentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Content build() => _build();

  _$Content _build() {
    _$Content _$result;
    try {
      _$result = _$v ??
          new _$Content._(
            type:
                BuiltValueNullFieldError.checkNotNull(type, r'Content', 'type'),
            text: text,
            imageUrl: _imageUrl?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'imageUrl';
        _imageUrl?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Content', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ImageUrl extends ImageUrl {
  @override
  final String url;

  factory _$ImageUrl([void Function(ImageUrlBuilder)? updates]) =>
      (new ImageUrlBuilder()..update(updates))._build();

  _$ImageUrl._({required this.url}) : super._() {
    BuiltValueNullFieldError.checkNotNull(url, r'ImageUrl', 'url');
  }

  @override
  ImageUrl rebuild(void Function(ImageUrlBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImageUrlBuilder toBuilder() => new ImageUrlBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImageUrl && url == other.url;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ImageUrl')..add('url', url))
        .toString();
  }
}

class ImageUrlBuilder implements Builder<ImageUrl, ImageUrlBuilder> {
  _$ImageUrl? _$v;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  ImageUrlBuilder();

  ImageUrlBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImageUrl other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ImageUrl;
  }

  @override
  void update(void Function(ImageUrlBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ImageUrl build() => _build();

  _$ImageUrl _build() {
    final _$result = _$v ??
        new _$ImageUrl._(
          url: BuiltValueNullFieldError.checkNotNull(url, r'ImageUrl', 'url'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

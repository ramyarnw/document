// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Thread> _$threadSerializer = new _$ThreadSerializer();

class _$ThreadSerializer implements StructuredSerializer<Thread> {
  @override
  final Iterable<Type> types = const [Thread, _$Thread];
  @override
  final String wireName = 'Thread';

  @override
  Iterable<Object?> serialize(Serializers serializers, Thread object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'image',
      serializers.serialize(object.image,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
      'aiData',
      serializers.serialize(object.aiData,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Thread deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ThreadBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'image':
          result.image.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'aiData':
          result.aiData = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Thread extends Thread {
  @override
  final String id;
  @override
  final BuiltList<int> image;
  @override
  final String aiData;

  factory _$Thread([void Function(ThreadBuilder)? updates]) =>
      (new ThreadBuilder()..update(updates))._build();

  _$Thread._({required this.id, required this.image, required this.aiData})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Thread', 'id');
    BuiltValueNullFieldError.checkNotNull(image, r'Thread', 'image');
    BuiltValueNullFieldError.checkNotNull(aiData, r'Thread', 'aiData');
  }

  @override
  Thread rebuild(void Function(ThreadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ThreadBuilder toBuilder() => new ThreadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Thread &&
        id == other.id &&
        image == other.image &&
        aiData == other.aiData;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, aiData.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Thread')
          ..add('id', id)
          ..add('image', image)
          ..add('aiData', aiData))
        .toString();
  }
}

class ThreadBuilder implements Builder<Thread, ThreadBuilder> {
  _$Thread? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  ListBuilder<int>? _image;
  ListBuilder<int> get image => _$this._image ??= new ListBuilder<int>();
  set image(ListBuilder<int>? image) => _$this._image = image;

  String? _aiData;
  String? get aiData => _$this._aiData;
  set aiData(String? aiData) => _$this._aiData = aiData;

  ThreadBuilder();

  ThreadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _image = $v.image.toBuilder();
      _aiData = $v.aiData;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Thread other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Thread;
  }

  @override
  void update(void Function(ThreadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Thread build() => _build();

  _$Thread _build() {
    _$Thread _$result;
    try {
      _$result = _$v ??
          new _$Thread._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Thread', 'id'),
            image: image.build(),
            aiData: BuiltValueNullFieldError.checkNotNull(
                aiData, r'Thread', 'aiData'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'image';
        image.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Thread', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

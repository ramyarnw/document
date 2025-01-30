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
      'imagePath',
      serializers.serialize(object.imagePath,
          specifiedType: const FullType(String)),
      'aiData',
      serializers.serialize(object.aiData,
          specifiedType: const FullType(String)),
      'fileName',
      serializers.serialize(object.fileName,
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
        case 'imagePath':
          result.imagePath = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'aiData':
          result.aiData = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'fileName':
          result.fileName = serializers.deserialize(value,
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
  final String imagePath;
  @override
  final String aiData;
  @override
  final String fileName;

  factory _$Thread([void Function(ThreadBuilder)? updates]) =>
      (new ThreadBuilder()..update(updates))._build();

  _$Thread._(
      {required this.id,
      required this.imagePath,
      required this.aiData,
      required this.fileName})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Thread', 'id');
    BuiltValueNullFieldError.checkNotNull(imagePath, r'Thread', 'imagePath');
    BuiltValueNullFieldError.checkNotNull(aiData, r'Thread', 'aiData');
    BuiltValueNullFieldError.checkNotNull(fileName, r'Thread', 'fileName');
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
        imagePath == other.imagePath &&
        aiData == other.aiData &&
        fileName == other.fileName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, imagePath.hashCode);
    _$hash = $jc(_$hash, aiData.hashCode);
    _$hash = $jc(_$hash, fileName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Thread')
          ..add('id', id)
          ..add('imagePath', imagePath)
          ..add('aiData', aiData)
          ..add('fileName', fileName))
        .toString();
  }
}

class ThreadBuilder implements Builder<Thread, ThreadBuilder> {
  _$Thread? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _imagePath;
  String? get imagePath => _$this._imagePath;
  set imagePath(String? imagePath) => _$this._imagePath = imagePath;

  String? _aiData;
  String? get aiData => _$this._aiData;
  set aiData(String? aiData) => _$this._aiData = aiData;

  String? _fileName;
  String? get fileName => _$this._fileName;
  set fileName(String? fileName) => _$this._fileName = fileName;

  ThreadBuilder() {
    Thread._initializeBuilder(this);
  }

  ThreadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _imagePath = $v.imagePath;
      _aiData = $v.aiData;
      _fileName = $v.fileName;
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
    final _$result = _$v ??
        new _$Thread._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Thread', 'id'),
          imagePath: BuiltValueNullFieldError.checkNotNull(
              imagePath, r'Thread', 'imagePath'),
          aiData: BuiltValueNullFieldError.checkNotNull(
              aiData, r'Thread', 'aiData'),
          fileName: BuiltValueNullFieldError.checkNotNull(
              fileName, r'Thread', 'fileName'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

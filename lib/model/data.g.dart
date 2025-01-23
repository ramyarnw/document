// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Data> _$dataSerializer = new _$DataSerializer();

class _$DataSerializer implements StructuredSerializer<Data> {
  @override
  final Iterable<Type> types = const [Data, _$Data];
  @override
  final String wireName = 'Data';

  @override
  Iterable<Object?> serialize(Serializers serializers, Data object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'aiData',
      serializers.serialize(object.aiData,
          specifiedType: const FullType(String)),
      'threadId',
      serializers.serialize(object.threadId,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Data deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'aiData':
          result.aiData = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'threadId':
          result.threadId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Data extends Data {
  @override
  final String aiData;
  @override
  final String threadId;

  factory _$Data([void Function(DataBuilder)? updates]) =>
      (new DataBuilder()..update(updates))._build();

  _$Data._({required this.aiData, required this.threadId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(aiData, r'Data', 'aiData');
    BuiltValueNullFieldError.checkNotNull(threadId, r'Data', 'threadId');
  }

  @override
  Data rebuild(void Function(DataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DataBuilder toBuilder() => new DataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Data &&
        aiData == other.aiData &&
        threadId == other.threadId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, aiData.hashCode);
    _$hash = $jc(_$hash, threadId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Data')
          ..add('aiData', aiData)
          ..add('threadId', threadId))
        .toString();
  }
}

class DataBuilder implements Builder<Data, DataBuilder> {
  _$Data? _$v;

  String? _aiData;
  String? get aiData => _$this._aiData;
  set aiData(String? aiData) => _$this._aiData = aiData;

  String? _threadId;
  String? get threadId => _$this._threadId;
  set threadId(String? threadId) => _$this._threadId = threadId;

  DataBuilder();

  DataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _aiData = $v.aiData;
      _threadId = $v.threadId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Data other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Data;
  }

  @override
  void update(void Function(DataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Data build() => _build();

  _$Data _build() {
    final _$result = _$v ??
        new _$Data._(
          aiData:
              BuiltValueNullFieldError.checkNotNull(aiData, r'Data', 'aiData'),
          threadId: BuiltValueNullFieldError.checkNotNull(
              threadId, r'Data', 'threadId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

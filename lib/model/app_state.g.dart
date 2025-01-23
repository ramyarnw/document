// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable<Object?> serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'threads',
      serializers.serialize(object.threads,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Thread)])),
      'datas',
      serializers.serialize(object.datas,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Data)])),
      'count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'threads':
          result.threads.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Thread)]))!
              as BuiltList<Object?>);
          break;
        case 'datas':
          result.datas.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Data)]))!
              as BuiltList<Object?>);
          break;
        case 'count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final BuiltList<Thread> threads;
  @override
  final BuiltList<Data> datas;
  @override
  final int count;

  factory _$AppState([void Function(AppStateBuilder)? updates]) =>
      (new AppStateBuilder()..update(updates))._build();

  _$AppState._(
      {required this.threads, required this.datas, required this.count})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(threads, r'AppState', 'threads');
    BuiltValueNullFieldError.checkNotNull(datas, r'AppState', 'datas');
    BuiltValueNullFieldError.checkNotNull(count, r'AppState', 'count');
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        threads == other.threads &&
        datas == other.datas &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, threads.hashCode);
    _$hash = $jc(_$hash, datas.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppState')
          ..add('threads', threads)
          ..add('datas', datas)
          ..add('count', count))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState? _$v;

  ListBuilder<Thread>? _threads;
  ListBuilder<Thread> get threads =>
      _$this._threads ??= new ListBuilder<Thread>();
  set threads(ListBuilder<Thread>? threads) => _$this._threads = threads;

  ListBuilder<Data>? _datas;
  ListBuilder<Data> get datas => _$this._datas ??= new ListBuilder<Data>();
  set datas(ListBuilder<Data>? datas) => _$this._datas = datas;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  AppStateBuilder();

  AppStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _threads = $v.threads.toBuilder();
      _datas = $v.datas.toBuilder();
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppState build() => _build();

  _$AppState _build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
            threads: threads.build(),
            datas: datas.build(),
            count: BuiltValueNullFieldError.checkNotNull(
                count, r'AppState', 'count'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'threads';
        threads.build();
        _$failedField = 'datas';
        datas.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'equipo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EquipoModel _$EquipoModelFromJson(Map<String, dynamic> json) {
  return _EquipoModel.fromJson(json);
}

/// @nodoc
mixin _$EquipoModel {
  String get id => throw _privateConstructorUsedError;
  String get nombre => throw _privateConstructorUsedError;
  @JsonKey(name: 'torneo_id')
  String get torneoId => throw _privateConstructorUsedError;
  Deporte get deporte => throw _privateConstructorUsedError;
  String get capitan => throw _privateConstructorUsedError;
  String get facultad => throw _privateConstructorUsedError;
  List<String> get integrantes => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: _timestampToDateTime)
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this EquipoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EquipoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EquipoModelCopyWith<EquipoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EquipoModelCopyWith<$Res> {
  factory $EquipoModelCopyWith(
          EquipoModel value, $Res Function(EquipoModel) then) =
      _$EquipoModelCopyWithImpl<$Res, EquipoModel>;
  @useResult
  $Res call(
      {String id,
      String nombre,
      @JsonKey(name: 'torneo_id') String torneoId,
      Deporte deporte,
      String capitan,
      String facultad,
      List<String> integrantes,
      @JsonKey(name: 'created_at', fromJson: _timestampToDateTime)
      DateTime createdAt});
}

/// @nodoc
class _$EquipoModelCopyWithImpl<$Res, $Val extends EquipoModel>
    implements $EquipoModelCopyWith<$Res> {
  _$EquipoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EquipoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? torneoId = null,
    Object? deporte = null,
    Object? capitan = null,
    Object? facultad = null,
    Object? integrantes = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      torneoId: null == torneoId
          ? _value.torneoId
          : torneoId // ignore: cast_nullable_to_non_nullable
              as String,
      deporte: null == deporte
          ? _value.deporte
          : deporte // ignore: cast_nullable_to_non_nullable
              as Deporte,
      capitan: null == capitan
          ? _value.capitan
          : capitan // ignore: cast_nullable_to_non_nullable
              as String,
      facultad: null == facultad
          ? _value.facultad
          : facultad // ignore: cast_nullable_to_non_nullable
              as String,
      integrantes: null == integrantes
          ? _value.integrantes
          : integrantes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EquipoModelImplCopyWith<$Res>
    implements $EquipoModelCopyWith<$Res> {
  factory _$$EquipoModelImplCopyWith(
          _$EquipoModelImpl value, $Res Function(_$EquipoModelImpl) then) =
      __$$EquipoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nombre,
      @JsonKey(name: 'torneo_id') String torneoId,
      Deporte deporte,
      String capitan,
      String facultad,
      List<String> integrantes,
      @JsonKey(name: 'created_at', fromJson: _timestampToDateTime)
      DateTime createdAt});
}

/// @nodoc
class __$$EquipoModelImplCopyWithImpl<$Res>
    extends _$EquipoModelCopyWithImpl<$Res, _$EquipoModelImpl>
    implements _$$EquipoModelImplCopyWith<$Res> {
  __$$EquipoModelImplCopyWithImpl(
      _$EquipoModelImpl _value, $Res Function(_$EquipoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EquipoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? torneoId = null,
    Object? deporte = null,
    Object? capitan = null,
    Object? facultad = null,
    Object? integrantes = null,
    Object? createdAt = null,
  }) {
    return _then(_$EquipoModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      torneoId: null == torneoId
          ? _value.torneoId
          : torneoId // ignore: cast_nullable_to_non_nullable
              as String,
      deporte: null == deporte
          ? _value.deporte
          : deporte // ignore: cast_nullable_to_non_nullable
              as Deporte,
      capitan: null == capitan
          ? _value.capitan
          : capitan // ignore: cast_nullable_to_non_nullable
              as String,
      facultad: null == facultad
          ? _value.facultad
          : facultad // ignore: cast_nullable_to_non_nullable
              as String,
      integrantes: null == integrantes
          ? _value._integrantes
          : integrantes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EquipoModelImpl extends _EquipoModel {
  const _$EquipoModelImpl(
      {required this.id,
      required this.nombre,
      @JsonKey(name: 'torneo_id') required this.torneoId,
      required this.deporte,
      required this.capitan,
      required this.facultad,
      required final List<String> integrantes,
      @JsonKey(name: 'created_at', fromJson: _timestampToDateTime)
      required this.createdAt})
      : _integrantes = integrantes,
        super._();

  factory _$EquipoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EquipoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String nombre;
  @override
  @JsonKey(name: 'torneo_id')
  final String torneoId;
  @override
  final Deporte deporte;
  @override
  final String capitan;
  @override
  final String facultad;
  final List<String> _integrantes;
  @override
  List<String> get integrantes {
    if (_integrantes is EqualUnmodifiableListView) return _integrantes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_integrantes);
  }

  @override
  @JsonKey(name: 'created_at', fromJson: _timestampToDateTime)
  final DateTime createdAt;

  @override
  String toString() {
    return 'EquipoModel(id: $id, nombre: $nombre, torneoId: $torneoId, deporte: $deporte, capitan: $capitan, facultad: $facultad, integrantes: $integrantes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EquipoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.torneoId, torneoId) ||
                other.torneoId == torneoId) &&
            (identical(other.deporte, deporte) || other.deporte == deporte) &&
            (identical(other.capitan, capitan) || other.capitan == capitan) &&
            (identical(other.facultad, facultad) ||
                other.facultad == facultad) &&
            const DeepCollectionEquality()
                .equals(other._integrantes, _integrantes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nombre,
      torneoId,
      deporte,
      capitan,
      facultad,
      const DeepCollectionEquality().hash(_integrantes),
      createdAt);

  /// Create a copy of EquipoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EquipoModelImplCopyWith<_$EquipoModelImpl> get copyWith =>
      __$$EquipoModelImplCopyWithImpl<_$EquipoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EquipoModelImplToJson(
      this,
    );
  }
}

abstract class _EquipoModel extends EquipoModel {
  const factory _EquipoModel(
      {required final String id,
      required final String nombre,
      @JsonKey(name: 'torneo_id') required final String torneoId,
      required final Deporte deporte,
      required final String capitan,
      required final String facultad,
      required final List<String> integrantes,
      @JsonKey(name: 'created_at', fromJson: _timestampToDateTime)
      required final DateTime createdAt}) = _$EquipoModelImpl;
  const _EquipoModel._() : super._();

  factory _EquipoModel.fromJson(Map<String, dynamic> json) =
      _$EquipoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get nombre;
  @override
  @JsonKey(name: 'torneo_id')
  String get torneoId;
  @override
  Deporte get deporte;
  @override
  String get capitan;
  @override
  String get facultad;
  @override
  List<String> get integrantes;
  @override
  @JsonKey(name: 'created_at', fromJson: _timestampToDateTime)
  DateTime get createdAt;

  /// Create a copy of EquipoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EquipoModelImplCopyWith<_$EquipoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

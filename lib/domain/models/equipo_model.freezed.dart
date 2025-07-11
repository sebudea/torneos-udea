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

IntegranteModel _$IntegranteModelFromJson(Map<String, dynamic> json) {
  return _IntegranteModel.fromJson(json);
}

/// @nodoc
mixin _$IntegranteModel {
  String get nombre => throw _privateConstructorUsedError;
  String get documento => throw _privateConstructorUsedError;
  int get numeroCamiseta => throw _privateConstructorUsedError;
  String? get posicion => throw _privateConstructorUsedError;

  /// Serializes this IntegranteModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IntegranteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IntegranteModelCopyWith<IntegranteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntegranteModelCopyWith<$Res> {
  factory $IntegranteModelCopyWith(
          IntegranteModel value, $Res Function(IntegranteModel) then) =
      _$IntegranteModelCopyWithImpl<$Res, IntegranteModel>;
  @useResult
  $Res call(
      {String nombre, String documento, int numeroCamiseta, String? posicion});
}

/// @nodoc
class _$IntegranteModelCopyWithImpl<$Res, $Val extends IntegranteModel>
    implements $IntegranteModelCopyWith<$Res> {
  _$IntegranteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IntegranteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = null,
    Object? documento = null,
    Object? numeroCamiseta = null,
    Object? posicion = freezed,
  }) {
    return _then(_value.copyWith(
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      documento: null == documento
          ? _value.documento
          : documento // ignore: cast_nullable_to_non_nullable
              as String,
      numeroCamiseta: null == numeroCamiseta
          ? _value.numeroCamiseta
          : numeroCamiseta // ignore: cast_nullable_to_non_nullable
              as int,
      posicion: freezed == posicion
          ? _value.posicion
          : posicion // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntegranteModelImplCopyWith<$Res>
    implements $IntegranteModelCopyWith<$Res> {
  factory _$$IntegranteModelImplCopyWith(_$IntegranteModelImpl value,
          $Res Function(_$IntegranteModelImpl) then) =
      __$$IntegranteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nombre, String documento, int numeroCamiseta, String? posicion});
}

/// @nodoc
class __$$IntegranteModelImplCopyWithImpl<$Res>
    extends _$IntegranteModelCopyWithImpl<$Res, _$IntegranteModelImpl>
    implements _$$IntegranteModelImplCopyWith<$Res> {
  __$$IntegranteModelImplCopyWithImpl(
      _$IntegranteModelImpl _value, $Res Function(_$IntegranteModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of IntegranteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nombre = null,
    Object? documento = null,
    Object? numeroCamiseta = null,
    Object? posicion = freezed,
  }) {
    return _then(_$IntegranteModelImpl(
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      documento: null == documento
          ? _value.documento
          : documento // ignore: cast_nullable_to_non_nullable
              as String,
      numeroCamiseta: null == numeroCamiseta
          ? _value.numeroCamiseta
          : numeroCamiseta // ignore: cast_nullable_to_non_nullable
              as int,
      posicion: freezed == posicion
          ? _value.posicion
          : posicion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntegranteModelImpl implements _IntegranteModel {
  const _$IntegranteModelImpl(
      {required this.nombre,
      required this.documento,
      required this.numeroCamiseta,
      this.posicion});

  factory _$IntegranteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntegranteModelImplFromJson(json);

  @override
  final String nombre;
  @override
  final String documento;
  @override
  final int numeroCamiseta;
  @override
  final String? posicion;

  @override
  String toString() {
    return 'IntegranteModel(nombre: $nombre, documento: $documento, numeroCamiseta: $numeroCamiseta, posicion: $posicion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntegranteModelImpl &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.documento, documento) ||
                other.documento == documento) &&
            (identical(other.numeroCamiseta, numeroCamiseta) ||
                other.numeroCamiseta == numeroCamiseta) &&
            (identical(other.posicion, posicion) ||
                other.posicion == posicion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nombre, documento, numeroCamiseta, posicion);

  /// Create a copy of IntegranteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IntegranteModelImplCopyWith<_$IntegranteModelImpl> get copyWith =>
      __$$IntegranteModelImplCopyWithImpl<_$IntegranteModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntegranteModelImplToJson(
      this,
    );
  }
}

abstract class _IntegranteModel implements IntegranteModel {
  const factory _IntegranteModel(
      {required final String nombre,
      required final String documento,
      required final int numeroCamiseta,
      final String? posicion}) = _$IntegranteModelImpl;

  factory _IntegranteModel.fromJson(Map<String, dynamic> json) =
      _$IntegranteModelImpl.fromJson;

  @override
  String get nombre;
  @override
  String get documento;
  @override
  int get numeroCamiseta;
  @override
  String? get posicion;

  /// Create a copy of IntegranteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IntegranteModelImplCopyWith<_$IntegranteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EquipoModel _$EquipoModelFromJson(Map<String, dynamic> json) {
  return _EquipoModel.fromJson(json);
}

/// @nodoc
mixin _$EquipoModel {
  String get id => throw _privateConstructorUsedError;
  String get nombre => throw _privateConstructorUsedError;
  String get torneoId => throw _privateConstructorUsedError;
  String get capitan => throw _privateConstructorUsedError;
  String get facultad => throw _privateConstructorUsedError;
  List<IntegranteModel> get integrantes => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: true, includeToJson: false)
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
      String torneoId,
      String capitan,
      String facultad,
      List<IntegranteModel> integrantes,
      @JsonKey(includeFromJson: true, includeToJson: false)
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
              as List<IntegranteModel>,
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
      String torneoId,
      String capitan,
      String facultad,
      List<IntegranteModel> integrantes,
      @JsonKey(includeFromJson: true, includeToJson: false)
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
              as List<IntegranteModel>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EquipoModelImpl implements _EquipoModel {
  const _$EquipoModelImpl(
      {required this.id,
      required this.nombre,
      required this.torneoId,
      required this.capitan,
      required this.facultad,
      required final List<IntegranteModel> integrantes,
      @JsonKey(includeFromJson: true, includeToJson: false)
      required this.createdAt})
      : _integrantes = integrantes;

  factory _$EquipoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EquipoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String nombre;
  @override
  final String torneoId;
  @override
  final String capitan;
  @override
  final String facultad;
  final List<IntegranteModel> _integrantes;
  @override
  List<IntegranteModel> get integrantes {
    if (_integrantes is EqualUnmodifiableListView) return _integrantes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_integrantes);
  }

  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  final DateTime createdAt;

  @override
  String toString() {
    return 'EquipoModel(id: $id, nombre: $nombre, torneoId: $torneoId, capitan: $capitan, facultad: $facultad, integrantes: $integrantes, createdAt: $createdAt)';
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
  int get hashCode => Object.hash(runtimeType, id, nombre, torneoId, capitan,
      facultad, const DeepCollectionEquality().hash(_integrantes), createdAt);

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

abstract class _EquipoModel implements EquipoModel {
  const factory _EquipoModel(
      {required final String id,
      required final String nombre,
      required final String torneoId,
      required final String capitan,
      required final String facultad,
      required final List<IntegranteModel> integrantes,
      @JsonKey(includeFromJson: true, includeToJson: false)
      required final DateTime createdAt}) = _$EquipoModelImpl;

  factory _EquipoModel.fromJson(Map<String, dynamic> json) =
      _$EquipoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get nombre;
  @override
  String get torneoId;
  @override
  String get capitan;
  @override
  String get facultad;
  @override
  List<IntegranteModel> get integrantes;
  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  DateTime get createdAt;

  /// Create a copy of EquipoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EquipoModelImplCopyWith<_$EquipoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'torneo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TorneoModel _$TorneoModelFromJson(Map<String, dynamic> json) {
  return _TorneoModel.fromJson(json);
}

/// @nodoc
mixin _$TorneoModel {
  String get id => throw _privateConstructorUsedError;
  String get nombre => throw _privateConstructorUsedError;
  Deporte get deporte => throw _privateConstructorUsedError;
  @JsonKey(name: 'metodo_eliminacion')
  MetodoEliminacion get metodoEliminacion => throw _privateConstructorUsedError;
  @JsonKey(name: 'cantidad_equipos')
  int get cantidadEquipos => throw _privateConstructorUsedError;
  EstadoTorneo get estado => throw _privateConstructorUsedError;
  @JsonKey(name: 'fecha_inicio_registro')
  DateTime get fechaInicioRegistro => throw _privateConstructorUsedError;
  @JsonKey(name: 'fecha_fin_registro')
  DateTime get fechaFinRegistro => throw _privateConstructorUsedError;
  @JsonKey(name: 'fecha_inicio_torneo')
  DateTime get fechaInicioTorneo => throw _privateConstructorUsedError;
  @JsonKey(name: 'fecha_fin_torneo')
  DateTime get fechaFinTorneo => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', includeFromJson: true, includeToJson: false)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at', includeFromJson: true, includeToJson: false)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;

  /// Serializes this TorneoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TorneoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TorneoModelCopyWith<TorneoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TorneoModelCopyWith<$Res> {
  factory $TorneoModelCopyWith(
          TorneoModel value, $Res Function(TorneoModel) then) =
      _$TorneoModelCopyWithImpl<$Res, TorneoModel>;
  @useResult
  $Res call(
      {String id,
      String nombre,
      Deporte deporte,
      @JsonKey(name: 'metodo_eliminacion') MetodoEliminacion metodoEliminacion,
      @JsonKey(name: 'cantidad_equipos') int cantidadEquipos,
      EstadoTorneo estado,
      @JsonKey(name: 'fecha_inicio_registro') DateTime fechaInicioRegistro,
      @JsonKey(name: 'fecha_fin_registro') DateTime fechaFinRegistro,
      @JsonKey(name: 'fecha_inicio_torneo') DateTime fechaInicioTorneo,
      @JsonKey(name: 'fecha_fin_torneo') DateTime fechaFinTorneo,
      @JsonKey(name: 'created_at', includeFromJson: true, includeToJson: false)
      DateTime? createdAt,
      @JsonKey(name: 'updated_at', includeFromJson: true, includeToJson: false)
      DateTime? updatedAt,
      @JsonKey(name: 'created_by') String createdBy});
}

/// @nodoc
class _$TorneoModelCopyWithImpl<$Res, $Val extends TorneoModel>
    implements $TorneoModelCopyWith<$Res> {
  _$TorneoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TorneoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? deporte = null,
    Object? metodoEliminacion = null,
    Object? cantidadEquipos = null,
    Object? estado = null,
    Object? fechaInicioRegistro = null,
    Object? fechaFinRegistro = null,
    Object? fechaInicioTorneo = null,
    Object? fechaFinTorneo = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? createdBy = null,
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
      deporte: null == deporte
          ? _value.deporte
          : deporte // ignore: cast_nullable_to_non_nullable
              as Deporte,
      metodoEliminacion: null == metodoEliminacion
          ? _value.metodoEliminacion
          : metodoEliminacion // ignore: cast_nullable_to_non_nullable
              as MetodoEliminacion,
      cantidadEquipos: null == cantidadEquipos
          ? _value.cantidadEquipos
          : cantidadEquipos // ignore: cast_nullable_to_non_nullable
              as int,
      estado: null == estado
          ? _value.estado
          : estado // ignore: cast_nullable_to_non_nullable
              as EstadoTorneo,
      fechaInicioRegistro: null == fechaInicioRegistro
          ? _value.fechaInicioRegistro
          : fechaInicioRegistro // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaFinRegistro: null == fechaFinRegistro
          ? _value.fechaFinRegistro
          : fechaFinRegistro // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaInicioTorneo: null == fechaInicioTorneo
          ? _value.fechaInicioTorneo
          : fechaInicioTorneo // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaFinTorneo: null == fechaFinTorneo
          ? _value.fechaFinTorneo
          : fechaFinTorneo // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TorneoModelImplCopyWith<$Res>
    implements $TorneoModelCopyWith<$Res> {
  factory _$$TorneoModelImplCopyWith(
          _$TorneoModelImpl value, $Res Function(_$TorneoModelImpl) then) =
      __$$TorneoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nombre,
      Deporte deporte,
      @JsonKey(name: 'metodo_eliminacion') MetodoEliminacion metodoEliminacion,
      @JsonKey(name: 'cantidad_equipos') int cantidadEquipos,
      EstadoTorneo estado,
      @JsonKey(name: 'fecha_inicio_registro') DateTime fechaInicioRegistro,
      @JsonKey(name: 'fecha_fin_registro') DateTime fechaFinRegistro,
      @JsonKey(name: 'fecha_inicio_torneo') DateTime fechaInicioTorneo,
      @JsonKey(name: 'fecha_fin_torneo') DateTime fechaFinTorneo,
      @JsonKey(name: 'created_at', includeFromJson: true, includeToJson: false)
      DateTime? createdAt,
      @JsonKey(name: 'updated_at', includeFromJson: true, includeToJson: false)
      DateTime? updatedAt,
      @JsonKey(name: 'created_by') String createdBy});
}

/// @nodoc
class __$$TorneoModelImplCopyWithImpl<$Res>
    extends _$TorneoModelCopyWithImpl<$Res, _$TorneoModelImpl>
    implements _$$TorneoModelImplCopyWith<$Res> {
  __$$TorneoModelImplCopyWithImpl(
      _$TorneoModelImpl _value, $Res Function(_$TorneoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TorneoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nombre = null,
    Object? deporte = null,
    Object? metodoEliminacion = null,
    Object? cantidadEquipos = null,
    Object? estado = null,
    Object? fechaInicioRegistro = null,
    Object? fechaFinRegistro = null,
    Object? fechaInicioTorneo = null,
    Object? fechaFinTorneo = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? createdBy = null,
  }) {
    return _then(_$TorneoModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nombre: null == nombre
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String,
      deporte: null == deporte
          ? _value.deporte
          : deporte // ignore: cast_nullable_to_non_nullable
              as Deporte,
      metodoEliminacion: null == metodoEliminacion
          ? _value.metodoEliminacion
          : metodoEliminacion // ignore: cast_nullable_to_non_nullable
              as MetodoEliminacion,
      cantidadEquipos: null == cantidadEquipos
          ? _value.cantidadEquipos
          : cantidadEquipos // ignore: cast_nullable_to_non_nullable
              as int,
      estado: null == estado
          ? _value.estado
          : estado // ignore: cast_nullable_to_non_nullable
              as EstadoTorneo,
      fechaInicioRegistro: null == fechaInicioRegistro
          ? _value.fechaInicioRegistro
          : fechaInicioRegistro // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaFinRegistro: null == fechaFinRegistro
          ? _value.fechaFinRegistro
          : fechaFinRegistro // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaInicioTorneo: null == fechaInicioTorneo
          ? _value.fechaInicioTorneo
          : fechaInicioTorneo // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fechaFinTorneo: null == fechaFinTorneo
          ? _value.fechaFinTorneo
          : fechaFinTorneo // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TorneoModelImpl implements _TorneoModel {
  const _$TorneoModelImpl(
      {required this.id,
      required this.nombre,
      required this.deporte,
      @JsonKey(name: 'metodo_eliminacion') required this.metodoEliminacion,
      @JsonKey(name: 'cantidad_equipos') required this.cantidadEquipos,
      required this.estado,
      @JsonKey(name: 'fecha_inicio_registro') required this.fechaInicioRegistro,
      @JsonKey(name: 'fecha_fin_registro') required this.fechaFinRegistro,
      @JsonKey(name: 'fecha_inicio_torneo') required this.fechaInicioTorneo,
      @JsonKey(name: 'fecha_fin_torneo') required this.fechaFinTorneo,
      @JsonKey(name: 'created_at', includeFromJson: true, includeToJson: false)
      this.createdAt,
      @JsonKey(name: 'updated_at', includeFromJson: true, includeToJson: false)
      this.updatedAt,
      @JsonKey(name: 'created_by') required this.createdBy});

  factory _$TorneoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TorneoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String nombre;
  @override
  final Deporte deporte;
  @override
  @JsonKey(name: 'metodo_eliminacion')
  final MetodoEliminacion metodoEliminacion;
  @override
  @JsonKey(name: 'cantidad_equipos')
  final int cantidadEquipos;
  @override
  final EstadoTorneo estado;
  @override
  @JsonKey(name: 'fecha_inicio_registro')
  final DateTime fechaInicioRegistro;
  @override
  @JsonKey(name: 'fecha_fin_registro')
  final DateTime fechaFinRegistro;
  @override
  @JsonKey(name: 'fecha_inicio_torneo')
  final DateTime fechaInicioTorneo;
  @override
  @JsonKey(name: 'fecha_fin_torneo')
  final DateTime fechaFinTorneo;
  @override
  @JsonKey(name: 'created_at', includeFromJson: true, includeToJson: false)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at', includeFromJson: true, includeToJson: false)
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;

  @override
  String toString() {
    return 'TorneoModel(id: $id, nombre: $nombre, deporte: $deporte, metodoEliminacion: $metodoEliminacion, cantidadEquipos: $cantidadEquipos, estado: $estado, fechaInicioRegistro: $fechaInicioRegistro, fechaFinRegistro: $fechaFinRegistro, fechaInicioTorneo: $fechaInicioTorneo, fechaFinTorneo: $fechaFinTorneo, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TorneoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nombre, nombre) || other.nombre == nombre) &&
            (identical(other.deporte, deporte) || other.deporte == deporte) &&
            (identical(other.metodoEliminacion, metodoEliminacion) ||
                other.metodoEliminacion == metodoEliminacion) &&
            (identical(other.cantidadEquipos, cantidadEquipos) ||
                other.cantidadEquipos == cantidadEquipos) &&
            (identical(other.estado, estado) || other.estado == estado) &&
            (identical(other.fechaInicioRegistro, fechaInicioRegistro) ||
                other.fechaInicioRegistro == fechaInicioRegistro) &&
            (identical(other.fechaFinRegistro, fechaFinRegistro) ||
                other.fechaFinRegistro == fechaFinRegistro) &&
            (identical(other.fechaInicioTorneo, fechaInicioTorneo) ||
                other.fechaInicioTorneo == fechaInicioTorneo) &&
            (identical(other.fechaFinTorneo, fechaFinTorneo) ||
                other.fechaFinTorneo == fechaFinTorneo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nombre,
      deporte,
      metodoEliminacion,
      cantidadEquipos,
      estado,
      fechaInicioRegistro,
      fechaFinRegistro,
      fechaInicioTorneo,
      fechaFinTorneo,
      createdAt,
      updatedAt,
      createdBy);

  /// Create a copy of TorneoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TorneoModelImplCopyWith<_$TorneoModelImpl> get copyWith =>
      __$$TorneoModelImplCopyWithImpl<_$TorneoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TorneoModelImplToJson(
      this,
    );
  }
}

abstract class _TorneoModel implements TorneoModel {
  const factory _TorneoModel(
      {required final String id,
      required final String nombre,
      required final Deporte deporte,
      @JsonKey(name: 'metodo_eliminacion')
      required final MetodoEliminacion metodoEliminacion,
      @JsonKey(name: 'cantidad_equipos') required final int cantidadEquipos,
      required final EstadoTorneo estado,
      @JsonKey(name: 'fecha_inicio_registro')
      required final DateTime fechaInicioRegistro,
      @JsonKey(name: 'fecha_fin_registro')
      required final DateTime fechaFinRegistro,
      @JsonKey(name: 'fecha_inicio_torneo')
      required final DateTime fechaInicioTorneo,
      @JsonKey(name: 'fecha_fin_torneo') required final DateTime fechaFinTorneo,
      @JsonKey(name: 'created_at', includeFromJson: true, includeToJson: false)
      final DateTime? createdAt,
      @JsonKey(name: 'updated_at', includeFromJson: true, includeToJson: false)
      final DateTime? updatedAt,
      @JsonKey(name: 'created_by')
      required final String createdBy}) = _$TorneoModelImpl;

  factory _TorneoModel.fromJson(Map<String, dynamic> json) =
      _$TorneoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get nombre;
  @override
  Deporte get deporte;
  @override
  @JsonKey(name: 'metodo_eliminacion')
  MetodoEliminacion get metodoEliminacion;
  @override
  @JsonKey(name: 'cantidad_equipos')
  int get cantidadEquipos;
  @override
  EstadoTorneo get estado;
  @override
  @JsonKey(name: 'fecha_inicio_registro')
  DateTime get fechaInicioRegistro;
  @override
  @JsonKey(name: 'fecha_fin_registro')
  DateTime get fechaFinRegistro;
  @override
  @JsonKey(name: 'fecha_inicio_torneo')
  DateTime get fechaInicioTorneo;
  @override
  @JsonKey(name: 'fecha_fin_torneo')
  DateTime get fechaFinTorneo;
  @override
  @JsonKey(name: 'created_at', includeFromJson: true, includeToJson: false)
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at', includeFromJson: true, includeToJson: false)
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;

  /// Create a copy of TorneoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TorneoModelImplCopyWith<_$TorneoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

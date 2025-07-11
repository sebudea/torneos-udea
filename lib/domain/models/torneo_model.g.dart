// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'torneo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TorneoModelImpl _$$TorneoModelImplFromJson(Map<String, dynamic> json) =>
    _$TorneoModelImpl(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      deporte: $enumDecode(_$DeporteEnumMap, json['deporte']),
      metodoEliminacion:
          $enumDecode(_$MetodoEliminacionEnumMap, json['metodo_eliminacion']),
      cantidadEquipos: (json['cantidad_equipos'] as num).toInt(),
      estado: $enumDecode(_$EstadoTorneoEnumMap, json['estado']),
      fechaInicioRegistro:
          DateTime.parse(json['fecha_inicio_registro'] as String),
      fechaFinRegistro: DateTime.parse(json['fecha_fin_registro'] as String),
      fechaInicioTorneo: DateTime.parse(json['fecha_inicio_torneo'] as String),
      fechaFinTorneo: DateTime.parse(json['fecha_fin_torneo'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdBy: json['created_by'] as String,
    );

Map<String, dynamic> _$$TorneoModelImplToJson(_$TorneoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'deporte': _$DeporteEnumMap[instance.deporte]!,
      'metodo_eliminacion':
          _$MetodoEliminacionEnumMap[instance.metodoEliminacion]!,
      'cantidad_equipos': instance.cantidadEquipos,
      'estado': _$EstadoTorneoEnumMap[instance.estado]!,
      'fecha_inicio_registro': instance.fechaInicioRegistro.toIso8601String(),
      'fecha_fin_registro': instance.fechaFinRegistro.toIso8601String(),
      'fecha_inicio_torneo': instance.fechaInicioTorneo.toIso8601String(),
      'fecha_fin_torneo': instance.fechaFinTorneo.toIso8601String(),
      'created_by': instance.createdBy,
    };

const _$DeporteEnumMap = {
  Deporte.futbol: 'FUTBOL',
  Deporte.baloncesto: 'BALONCESTO',
  Deporte.voleibol: 'VOLEIBOL',
};

const _$MetodoEliminacionEnumMap = {
  MetodoEliminacion.eliminacionDirecta: 'ELIMINACION_DIRECTA',
  MetodoEliminacion.grupos: 'GRUPOS',
  MetodoEliminacion.todosContraTodos: 'TODOS_CONTRA_TODOS',
};

const _$EstadoTorneoEnumMap = {
  EstadoTorneo.registro: 'REGISTRO',
  EstadoTorneo.enProgreso: 'EN_PROGRESO',
  EstadoTorneo.finalizado: 'FINALIZADO',
};

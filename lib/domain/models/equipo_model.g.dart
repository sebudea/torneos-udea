// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EquipoModelImpl _$$EquipoModelImplFromJson(Map<String, dynamic> json) =>
    _$EquipoModelImpl(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      torneoId: json['torneo_id'] as String,
      deporte: _deporteFromJson(json['deporte'] as String),
      capitan: json['capitan'] as String,
      facultad: json['facultad'] as String,
      integrantes: (json['integrantes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: _timestampToDateTime(json['created_at']),
    );

Map<String, dynamic> _$$EquipoModelImplToJson(_$EquipoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'torneo_id': instance.torneoId,
      'deporte': _$DeporteEnumMap[instance.deporte]!,
      'capitan': instance.capitan,
      'facultad': instance.facultad,
      'integrantes': instance.integrantes,
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$DeporteEnumMap = {
  Deporte.futbol: 'FUTBOL',
  Deporte.baloncesto: 'BALONCESTO',
  Deporte.voleibol: 'VOLEIBOL',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntegranteModelImpl _$$IntegranteModelImplFromJson(
        Map<String, dynamic> json) =>
    _$IntegranteModelImpl(
      nombre: json['nombre'] as String,
      documento: json['documento'] as String,
      numeroCamiseta: (json['numero_camiseta'] as num).toInt(),
      posicion: json['posicion'] as String?,
    );

Map<String, dynamic> _$$IntegranteModelImplToJson(
        _$IntegranteModelImpl instance) =>
    <String, dynamic>{
      'nombre': instance.nombre,
      'documento': instance.documento,
      'numero_camiseta': instance.numeroCamiseta,
      if (instance.posicion case final value?) 'posicion': value,
    };

_$EquipoModelImpl _$$EquipoModelImplFromJson(Map<String, dynamic> json) =>
    _$EquipoModelImpl(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      torneoId: json['torneo_id'] as String,
      capitan: json['capitan'] as String,
      facultad: json['facultad'] as String,
      integrantes: (json['integrantes'] as List<dynamic>)
          .map((e) => IntegranteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$EquipoModelImplToJson(_$EquipoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'torneo_id': instance.torneoId,
      'capitan': instance.capitan,
      'facultad': instance.facultad,
      'integrantes': instance.integrantes,
    };

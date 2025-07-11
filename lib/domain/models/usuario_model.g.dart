// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UsuarioModelImpl _$$UsuarioModelImplFromJson(Map<String, dynamic> json) =>
    _$UsuarioModelImpl(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      email: json['email'] as String,
      rol: $enumDecode(_$RolUsuarioEnumMap, json['rol']),
      activo: json['activo'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$UsuarioModelImplToJson(_$UsuarioModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'email': instance.email,
      'rol': _$RolUsuarioEnumMap[instance.rol]!,
      'activo': instance.activo,
    };

const _$RolUsuarioEnumMap = {
  RolUsuario.admin: 'ADMIN',
  RolUsuario.user: 'USER',
};

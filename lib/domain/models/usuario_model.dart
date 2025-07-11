import 'package:freezed_annotation/freezed_annotation.dart';

part 'usuario_model.freezed.dart';
part 'usuario_model.g.dart';

enum RolUsuario {
  @JsonValue('ADMIN')
  admin,
  @JsonValue('USER')
  user,
}

@freezed
class UsuarioModel with _$UsuarioModel {
  const factory UsuarioModel({
    required String id,
    required String nombre,
    required String email,
    required RolUsuario rol,
    @Default(true) bool activo,
    @JsonKey(includeFromJson: true, includeToJson: false)
    required DateTime createdAt,
    @JsonKey(includeFromJson: true, includeToJson: false)
    required DateTime updatedAt,
  }) = _UsuarioModel;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) =>
      _$UsuarioModelFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'equipo_model.freezed.dart';
part 'equipo_model.g.dart';

@freezed
class IntegranteModel with _$IntegranteModel {
  const factory IntegranteModel({
    required String nombre,
    required String documento,
    required int numeroCamiseta,
    String? posicion,
  }) = _IntegranteModel;

  factory IntegranteModel.fromJson(Map<String, dynamic> json) =>
      _$IntegranteModelFromJson(json);
}

@freezed
class EquipoModel with _$EquipoModel {
  const factory EquipoModel({
    required String id,
    required String nombre,
    required String torneoId,
    required String capitan,
    required String facultad,
    required List<IntegranteModel> integrantes,
    @JsonKey(includeFromJson: true, includeToJson: false)
    required DateTime createdAt,
  }) = _EquipoModel;

  factory EquipoModel.fromJson(Map<String, dynamic> json) =>
      _$EquipoModelFromJson(json);
}

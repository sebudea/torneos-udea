import 'package:freezed_annotation/freezed_annotation.dart';

part 'torneo_model.freezed.dart';
part 'torneo_model.g.dart';

enum Deporte {
  @JsonValue('FUTBOL')
  futbol,
  @JsonValue('BALONCESTO')
  baloncesto,
  @JsonValue('VOLEIBOL')
  voleibol,
}

enum MetodoEliminacion {
  @JsonValue('ELIMINACION_DIRECTA')
  eliminacionDirecta,
  @JsonValue('GRUPOS')
  grupos,
  @JsonValue('TODOS_CONTRA_TODOS')
  todosContraTodos,
}

enum EstadoTorneo {
  @JsonValue('REGISTRO')
  registro,
  @JsonValue('EN_PROGRESO')
  enProgreso,
  @JsonValue('FINALIZADO')
  finalizado,
}

@freezed
class TorneoModel with _$TorneoModel {
  const factory TorneoModel({
    required String id,
    required String nombre,
    required Deporte deporte,
    @JsonKey(name: 'metodo_eliminacion')
    required MetodoEliminacion metodoEliminacion,
    @JsonKey(name: 'cantidad_equipos') required int cantidadEquipos,
    required EstadoTorneo estado,
    @JsonKey(name: 'fecha_inicio_registro')
    required DateTime fechaInicioRegistro,
    @JsonKey(name: 'fecha_fin_registro') required DateTime fechaFinRegistro,
    @JsonKey(name: 'fecha_inicio_torneo') required DateTime fechaInicioTorneo,
    @JsonKey(name: 'fecha_fin_torneo') required DateTime fechaFinTorneo,
    @JsonKey(name: 'created_at', includeFromJson: true, includeToJson: false)
    DateTime? createdAt,
    @JsonKey(name: 'updated_at', includeFromJson: true, includeToJson: false)
    DateTime? updatedAt,
    @JsonKey(name: 'created_by') required String createdBy,
  }) = _TorneoModel;

  factory TorneoModel.fromJson(Map<String, dynamic> json) =>
      _$TorneoModelFromJson(json);
}

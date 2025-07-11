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
    required MetodoEliminacion metodoEliminacion,
    required int cantidadEquipos,
    required EstadoTorneo estado,
    required DateTime fechaInicioRegistro,
    required DateTime fechaFinRegistro,
    required DateTime fechaInicioTorneo,
    required DateTime fechaFinTorneo,
    @JsonKey(includeFromJson: true, includeToJson: false)
    required DateTime createdAt,
    @JsonKey(includeFromJson: true, includeToJson: false)
    required DateTime updatedAt,
    required String createdBy,
  }) = _TorneoModel;

  factory TorneoModel.fromJson(Map<String, dynamic> json) =>
      _$TorneoModelFromJson(json);
}

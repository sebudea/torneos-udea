import 'package:freezed_annotation/freezed_annotation.dart';

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

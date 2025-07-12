import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'equipo_model.freezed.dart';
part 'equipo_model.g.dart';

// Convertidor para Timestamp <-> DateTime
DateTime _timestampToDateTime(dynamic timestamp) {
  if (timestamp is Timestamp) {
    return timestamp.toDate();
  } else if (timestamp is DateTime) {
    return timestamp;
  }
  throw Exception('Invalid timestamp format');
}

enum Deporte {
  @JsonValue('futbol')
  futbol,
  @JsonValue('baloncesto')
  baloncesto,
  @JsonValue('voleibol')
  voleibol,
}

@freezed
class EquipoModel with _$EquipoModel {
  // Constructor privado para poder agregar métodos
  const EquipoModel._();

  const factory EquipoModel({
    required String id,
    required String nombre,
    @JsonKey(name: 'torneo_id') required String torneoId,
    required Deporte deporte,
    required String capitan,
    required String facultad,
    required List<String> integrantes,
    @JsonKey(
      name: 'created_at',
      fromJson: _timestampToDateTime,
    )
    required DateTime createdAt,
  }) = _EquipoModel;

  factory EquipoModel.fromJson(Map<String, dynamic> json) =>
      _$EquipoModelFromJson(json);

  // Validación de número exacto de integrantes según el deporte
  bool get tieneIntegrantesValidos {
    final numeroRequerido = numeroIntegrantes;
    return integrantes.length == numeroRequerido;
  }

  // Número exacto de integrantes requeridos según el deporte
  int get numeroIntegrantes {
    switch (deporte) {
      case Deporte.futbol:
        return 11; // Formato clásico 11 vs 11
      case Deporte.baloncesto:
        return 5; // Formato clásico 5 vs 5
      case Deporte.voleibol:
        return 6; // Formato clásico 6 vs 6
    }
  }

  // Mensaje de error para validación
  String get mensajeValidacion {
    final numero = numeroIntegrantes;
    return 'Un equipo de ${deporte.name} debe tener exactamente $numero integrantes';
  }
}

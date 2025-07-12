import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:torneos_udea/domain/models/enums.dart';
import 'package:torneos_udea/domain/models/equipo_model.dart';

part 'equipos_provider.g.dart';

@riverpod
class EquiposNotifier extends _$EquiposNotifier {
  late final FirebaseFirestore _db;

  @override
  Future<List<EquipoModel>> build() async {
    _db = FirebaseFirestore.instance;

    try {
      // Escuchar cambios en tiempo real
      final snapshot = await _db.collection('equipos').get();

      final equipos = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        // Asegurarnos de que created_at sea un Timestamp
        if (data['created_at'] is! Timestamp) {
          data['created_at'] = Timestamp.now();
        }
        return EquipoModel.fromJson(data);
      }).toList();

      return equipos;
    } catch (e, st) {
      log('Error al cargar equipos', error: e, stackTrace: st);
      throw Exception('Error al cargar los equipos: $e');
    }
  }

  List<EquipoModel> filtrarEquipos({
    Deporte? deporte,
    String? facultad,
  }) {
    final equipos = state.value ?? [];

    return equipos.where((equipo) {
      final matchDeporte = deporte == null || equipo.deporte == deporte;
      final matchFacultad = facultad == null ||
          equipo.facultad.toLowerCase().contains(facultad.toLowerCase());

      return matchDeporte && matchFacultad;
    }).toList();
  }

  Future<void> crearEquipo(EquipoModel equipo) async {
    try {
      // Convertir el equipo a JSON
      final equipoJson = equipo.toJson();

      final docRef = await _db.collection('equipos').add(equipoJson);

      // Actualizar el estado local
      state = AsyncData([
        ...state.value ?? [],
        equipo.copyWith(id: docRef.id),
      ]);
    } catch (e, st) {
      log('Error al crear equipo', error: e, stackTrace: st);
      throw Exception('Error al crear el equipo: $e');
    }
  }

  Future<void> actualizarEquipo(EquipoModel equipo) async {
    try {
      await _db.collection('equipos').doc(equipo.id).update(equipo.toJson());

      // Actualizar el estado local
      state = AsyncData(
        (state.value ?? []).map((e) => e.id == equipo.id ? equipo : e).toList(),
      );
    } catch (e, st) {
      log('Error al actualizar equipo', error: e, stackTrace: st);
      throw Exception('Error al actualizar el equipo: $e');
    }
  }

  Future<void> eliminarEquipo(String id) async {
    try {
      await _db.collection('equipos').doc(id).delete();

      // Actualizar el estado local
      state = AsyncData(
        (state.value ?? []).where((e) => e.id != id).toList(),
      );
    } catch (e, st) {
      log('Error al eliminar equipo', error: e, stackTrace: st);
      throw Exception('Error al eliminar el equipo: $e');
    }
  }
}

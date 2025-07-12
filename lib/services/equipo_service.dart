import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:torneos_udea/domain/models/equipo_model.dart';

class EquipoService {
  static final _db = FirebaseFirestore.instance;
  static const _collection = 'equipos';

  // Crear un nuevo equipo
  static Future<void> createEquipo(EquipoModel equipo) async {
    try {
      log('Creando equipo: ${equipo.toJson()}');
      final docRef = _db.collection(_collection).doc(equipo.id);

      // Convertir el equipo a JSON y agregar los timestamps del servidor
      final equipoData = {
        ...equipo.toJson(),
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      };

      await docRef.set(equipoData);
      log('Equipo creado exitosamente');
    } catch (e, stackTrace) {
      log('Error al crear equipo: $e\n$stackTrace');
      throw Exception('Error al crear el equipo: $e');
    }
  }

  // Obtener todos los equipos
  static Stream<List<EquipoModel>> getEquipos() {
    try {
      log('Obteniendo equipos...');
      return _db
          .collection(_collection)
          .orderBy('created_at', descending: true)
          .snapshots()
          .map((snapshot) {
        final equipos = snapshot.docs.map((doc) {
          final data = doc.data();
          log('Procesando documento: ${doc.id}');
          log('Datos raw: $data');

          // Convertir timestamps a fechas ISO 8601
          try {
            if (data['created_at'] != null) {
              final createdAt = data['created_at'] as Timestamp;
              data['created_at'] = createdAt.toDate().toIso8601String();
            }

            if (data['updated_at'] != null) {
              final updatedAt = data['updated_at'] as Timestamp;
              data['updated_at'] = updatedAt.toDate().toIso8601String();
            }

            log('Datos procesados: $data');
            return EquipoModel.fromJson(data);
          } catch (e, stackTrace) {
            log('Error procesando equipo ${doc.id}: $e\n$stackTrace');
            log('Datos que causaron el error: $data');
            rethrow;
          }
        }).toList();

        log('Equipos obtenidos: ${equipos.length}');
        return equipos;
      });
    } catch (e, stackTrace) {
      log('Error al obtener equipos: $e\n$stackTrace');
      throw Exception('Error al obtener los equipos: $e');
    }
  }

  // Actualizar un equipo
  static Future<void> updateEquipo(EquipoModel equipo) async {
    try {
      log('Actualizando equipo: ${equipo.id}');
      final equipoData = {
        ...equipo.toJson(),
        'updated_at': FieldValue.serverTimestamp(),
      };
      await _db.collection(_collection).doc(equipo.id).update(equipoData);
      log('Equipo actualizado exitosamente');
    } catch (e, stackTrace) {
      log('Error al actualizar equipo: $e\n$stackTrace');
      throw Exception('Error al actualizar el equipo: $e');
    }
  }

  // Eliminar un equipo
  static Future<void> deleteEquipo(String id) async {
    try {
      log('Eliminando equipo: $id');
      await _db.collection(_collection).doc(id).delete();
      log('Equipo eliminado exitosamente');
    } catch (e, stackTrace) {
      log('Error al eliminar equipo: $e\n$stackTrace');
      throw Exception('Error al eliminar el equipo: $e');
    }
  }

  // Obtener un equipo por ID
  static Future<EquipoModel?> getEquipoById(String id) async {
    try {
      log('Obteniendo equipo por ID: $id');
      final doc = await _db.collection(_collection).doc(id).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        log('Datos raw del equipo: $data');

        try {
          // Convertir timestamps a fechas ISO 8601
          if (data['created_at'] != null) {
            final createdAt = data['created_at'] as Timestamp;
            data['created_at'] = createdAt.toDate().toIso8601String();
          }

          if (data['updated_at'] != null) {
            final updatedAt = data['updated_at'] as Timestamp;
            data['updated_at'] = updatedAt.toDate().toIso8601String();
          }

          log('Datos procesados del equipo: $data');
          final equipo = EquipoModel.fromJson(data);
          log('Equipo encontrado: ${equipo.nombre}');
          return equipo;
        } catch (e, stackTrace) {
          log('Error procesando equipo $id: $e\n$stackTrace');
          log('Datos que causaron el error: $data');
          rethrow;
        }
      }
      log('Equipo no encontrado');
      return null;
    } catch (e, stackTrace) {
      log('Error al obtener equipo: $e\n$stackTrace');
      throw Exception('Error al obtener el equipo: $e');
    }
  }
}

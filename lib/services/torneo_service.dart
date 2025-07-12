import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:torneos_udea/domain/models/torneo_model.dart';

class TorneoService {
  static final _db = FirebaseFirestore.instance;
  static const _collection = 'torneos';

  // Crear un nuevo torneo
  static Future<void> createTorneo(TorneoModel torneo) async {
    try {
      log('Creando torneo: ${torneo.toJson()}');
      final docRef = _db.collection(_collection).doc(torneo.id);

      // Convertir el torneo a JSON y agregar los timestamps del servidor
      final torneoData = {
        ...torneo.toJson(),
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      };

      await docRef.set(torneoData);
      log('Torneo creado exitosamente');
    } catch (e, stackTrace) {
      log('Error al crear torneo: $e\n$stackTrace');
      throw Exception('Error al crear el torneo: $e');
    }
  }

  // Obtener todos los torneos
  static Stream<List<TorneoModel>> getTorneos() {
    try {
      log('Obteniendo torneos...');
      return _db
          .collection(_collection)
          .orderBy('created_at', descending: true)
          .snapshots()
          .map((snapshot) {
        final torneos = snapshot.docs.map((doc) {
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

            // Asegurarse de que las fechas estén en formato ISO 8601
            final fechas = [
              'fecha_inicio_registro',
              'fecha_fin_registro',
              'fecha_inicio_torneo',
              'fecha_fin_torneo',
            ];

            for (final fecha in fechas) {
              if (data[fecha] != null) {
                if (data[fecha] is Timestamp) {
                  data[fecha] =
                      (data[fecha] as Timestamp).toDate().toIso8601String();
                } else if (data[fecha] is String) {
                  // Ya está en formato ISO 8601, no hacer nada
                  continue;
                } else {
                  log('Campo $fecha tiene un tipo inesperado: ${data[fecha].runtimeType}');
                }
              }
            }

            log('Datos procesados: $data');
            return TorneoModel.fromJson(data);
          } catch (e, stackTrace) {
            log('Error procesando torneo ${doc.id}: $e\n$stackTrace');
            log('Datos que causaron el error: $data');
            rethrow;
          }
        }).toList();

        log('Torneos obtenidos: ${torneos.length}');
        return torneos;
      });
    } catch (e, stackTrace) {
      log('Error al obtener torneos: $e\n$stackTrace');
      throw Exception('Error al obtener los torneos: $e');
    }
  }

  // Actualizar un torneo
  static Future<void> updateTorneo(TorneoModel torneo) async {
    try {
      log('Actualizando torneo: ${torneo.id}');
      final torneoData = {
        ...torneo.toJson(),
        'updated_at': FieldValue.serverTimestamp(),
      };
      await _db.collection(_collection).doc(torneo.id).update(torneoData);
      log('Torneo actualizado exitosamente');
    } catch (e, stackTrace) {
      log('Error al actualizar torneo: $e\n$stackTrace');
      throw Exception('Error al actualizar el torneo: $e');
    }
  }

  // Eliminar un torneo
  static Future<void> deleteTorneo(String id) async {
    try {
      log('Eliminando torneo: $id');
      await _db.collection(_collection).doc(id).delete();
      log('Torneo eliminado exitosamente');
    } catch (e, stackTrace) {
      log('Error al eliminar torneo: $e\n$stackTrace');
      throw Exception('Error al eliminar el torneo: $e');
    }
  }

  // Obtener un torneo por ID
  static Future<TorneoModel?> getTorneoById(String id) async {
    try {
      log('Obteniendo torneo por ID: $id');
      final doc = await _db.collection(_collection).doc(id).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        log('Datos raw del torneo: $data');

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

          // Asegurarse de que las fechas estén en formato ISO 8601
          final fechas = [
            'fecha_inicio_registro',
            'fecha_fin_registro',
            'fecha_inicio_torneo',
            'fecha_fin_torneo',
          ];

          for (final fecha in fechas) {
            if (data[fecha] != null) {
              if (data[fecha] is Timestamp) {
                data[fecha] =
                    (data[fecha] as Timestamp).toDate().toIso8601String();
              } else if (data[fecha] is String) {
                // Ya está en formato ISO 8601, no hacer nada
                continue;
              } else {
                log('Campo $fecha tiene un tipo inesperado: ${data[fecha].runtimeType}');
              }
            }
          }

          log('Datos procesados del torneo: $data');
          final torneo = TorneoModel.fromJson(data);
          log('Torneo encontrado: ${torneo.nombre}');
          return torneo;
        } catch (e, stackTrace) {
          log('Error procesando torneo $id: $e\n$stackTrace');
          log('Datos que causaron el error: $data');
          rethrow;
        }
      }
      log('Torneo no encontrado');
      return null;
    } catch (e, stackTrace) {
      log('Error al obtener torneo: $e\n$stackTrace');
      throw Exception('Error al obtener el torneo: $e');
    }
  }
}

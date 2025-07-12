import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:torneos_udea/domain/models/enums.dart';
import 'package:torneos_udea/domain/models/torneo_model.dart';
import 'package:torneos_udea/services/torneo_service.dart';

part 'torneos_provider.g.dart';

@Riverpod(keepAlive: true)
class TorneosNotifier extends AsyncNotifier<List<TorneoModel>> {
  @override
  Future<List<TorneoModel>> build() async {
    try {
      log('Inicializando TorneosNotifier...');

      // Obtener la lista inicial
      final initialTorneos = await TorneoService.getTorneos().first;
      log('Lista inicial obtenida: ${initialTorneos.length} torneos');

      // Configurar el stream listener
      TorneoService.getTorneos().listen(
        (torneos) {
          log('Stream actualizado: ${torneos.length} torneos');
          state = AsyncData(torneos);
        },
        onError: (error, stackTrace) {
          log('Error en el stream: $error\n$stackTrace');
          state = AsyncError(error, stackTrace);
        },
      );

      return initialTorneos;
    } catch (e, stackTrace) {
      log('Error al inicializar TorneosNotifier: $e\n$stackTrace');
      state = AsyncError(e, stackTrace);
      return [];
    }
  }

  Future<void> agregarTorneo(TorneoModel torneo) async {
    try {
      log('Agregando torneo: ${torneo.nombre}');
      await TorneoService.createTorneo(torneo);
      log('Torneo agregado exitosamente');
    } catch (e, stackTrace) {
      log('Error al agregar torneo: $e\n$stackTrace');
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> actualizarTorneo(TorneoModel torneo) async {
    try {
      log('Actualizando torneo: ${torneo.nombre}');
      await TorneoService.updateTorneo(torneo);
      log('Torneo actualizado exitosamente');
    } catch (e, stackTrace) {
      log('Error al actualizar torneo: $e\n$stackTrace');
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> eliminarTorneo(String id) async {
    try {
      log('Eliminando torneo: $id');
      await TorneoService.deleteTorneo(id);
      log('Torneo eliminado exitosamente');
    } catch (e, stackTrace) {
      log('Error al eliminar torneo: $e\n$stackTrace');
      state = AsyncError(e, stackTrace);
    }
  }

  List<TorneoModel> filtrarTorneos({
    Deporte? deporte,
    EstadoTorneo? estado,
  }) {
    final torneos = state.valueOrNull ?? [];

    if (deporte != null && estado != null) {
      return torneos
          .where((t) => t.deporte == deporte && t.estado == estado)
          .toList();
    }

    if (deporte != null) {
      return torneos.where((t) => t.deporte == deporte).toList();
    }

    if (estado != null) {
      return torneos.where((t) => t.estado == estado).toList();
    }

    return torneos;
  }
}

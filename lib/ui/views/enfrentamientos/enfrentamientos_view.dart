import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torneos_udea/domain/models/torneo_model.dart';
import 'package:torneos_udea/domain/models/enums.dart';
import 'package:torneos_udea/domain/models/usuario_model.dart';
import 'package:torneos_udea/ui/providers/auth_provider.dart';
import 'package:torneos_udea/ui/views/enfrentamientos/editar_resultado_dialog.dart';

class EnfrentamientosView extends ConsumerStatefulWidget {
  final TorneoModel torneo;

  const EnfrentamientosView({
    super.key,
    required this.torneo,
  });

  @override
  ConsumerState<EnfrentamientosView> createState() =>
      _EnfrentamientosViewState();
}

class _EnfrentamientosViewState extends ConsumerState<EnfrentamientosView> {
  // Datos simulados de enfrentamientos por fase
  late Map<String, List<Map<String, dynamic>>> enfrentamientos;

  @override
  void initState() {
    super.initState();
    enfrentamientos = {
      'Octavos de Final': [
        {
          'id': '1',
          'equipoLocal': 'Equipo A',
          'equipoVisitante': 'Equipo B',
          'fecha': '2024-05-15 14:00',
          'estado': 'Finalizado',
          'resultado': '2 - 1',
          'ganador': 'Equipo A',
        },
        {
          'id': '2',
          'equipoLocal': 'Equipo C',
          'equipoVisitante': 'Equipo D',
          'fecha': '2024-05-15 16:00',
          'estado': 'Finalizado',
          'resultado': '3 - 0',
          'ganador': 'Equipo C',
        },
        {
          'id': '3',
          'equipoLocal': 'Equipo E',
          'equipoVisitante': 'Equipo F',
          'fecha': '2024-05-16 14:00',
          'estado': 'Programado',
        },
        {
          'id': '4',
          'equipoLocal': 'Equipo G',
          'equipoVisitante': 'Equipo H',
          'fecha': '2024-05-16 16:00',
          'estado': 'Programado',
        },
        {
          'id': '5',
          'equipoLocal': 'Equipo I',
          'equipoVisitante': 'Equipo J',
          'fecha': '2024-05-17 14:00',
          'estado': 'Programado',
        },
        {
          'id': '6',
          'equipoLocal': 'Equipo K',
          'equipoVisitante': 'Equipo L',
          'fecha': '2024-05-17 16:00',
          'estado': 'Programado',
        },
        {
          'id': '7',
          'equipoLocal': 'Equipo M',
          'equipoVisitante': 'Equipo N',
          'fecha': '2024-05-18 14:00',
          'estado': 'Programado',
        },
        {
          'id': '8',
          'equipoLocal': 'Equipo O',
          'equipoVisitante': 'Equipo P',
          'fecha': '2024-05-18 16:00',
          'estado': 'Programado',
        },
      ],
      'Cuartos de Final': [
        {
          'id': '9',
          'equipoLocal': 'Equipo A',
          'equipoVisitante': 'Equipo C',
          'fecha': '2024-05-20 14:00',
          'estado': 'Programado',
        },
        {
          'id': '10',
          'equipoLocal': null,
          'equipoVisitante': null,
          'fecha': '2024-05-20 16:00',
          'estado': 'Pendiente',
        },
        {
          'id': '11',
          'equipoLocal': null,
          'equipoVisitante': null,
          'fecha': '2024-05-21 14:00',
          'estado': 'Pendiente',
        },
        {
          'id': '12',
          'equipoLocal': null,
          'equipoVisitante': null,
          'fecha': '2024-05-21 16:00',
          'estado': 'Pendiente',
        },
      ],
      'Semifinal': [
        {
          'id': '13',
          'equipoLocal': null,
          'equipoVisitante': null,
          'fecha': '2024-05-25 14:00',
          'estado': 'Pendiente',
        },
        {
          'id': '14',
          'equipoLocal': null,
          'equipoVisitante': null,
          'fecha': '2024-05-25 16:00',
          'estado': 'Pendiente',
        },
      ],
      'Final': [
        {
          'id': '15',
          'equipoLocal': null,
          'equipoVisitante': null,
          'fecha': '2024-05-30 14:00',
          'estado': 'Pendiente',
        },
      ],
    };
  }

  void _actualizarEnfrentamiento(
      Map<String, dynamic> enfrentamientoActualizado) {
    setState(() {
      // Encontrar y actualizar el enfrentamiento
      for (var fase in enfrentamientos.keys) {
        final index = enfrentamientos[fase]!.indexWhere(
          (e) => e['id'] == enfrentamientoActualizado['id'],
        );
        if (index != -1) {
          enfrentamientos[fase]![index] = enfrentamientoActualizado;
          // Si el partido está finalizado, actualizar el siguiente enfrentamiento
          if (enfrentamientoActualizado['estado'] == 'Finalizado') {
            _actualizarSiguienteEnfrentamiento(
              fase,
              enfrentamientoActualizado,
            );
          }
          break;
        }
      }
    });
  }

  void _actualizarSiguienteEnfrentamiento(
    String faseActual,
    Map<String, dynamic> enfrentamientoActual,
  ) {
    // Mapeo de fases y sus siguientes
    final siguienteFase = {
      'Octavos de Final': 'Cuartos de Final',
      'Cuartos de Final': 'Semifinal',
      'Semifinal': 'Final',
    };

    // Si no hay siguiente fase, retornar
    if (!siguienteFase.containsKey(faseActual)) return;

    final fase = siguienteFase[faseActual]!;
    final partidosSiguienteFase = enfrentamientos[fase]!;

    // Encontrar el primer partido pendiente o con equipos nulos
    final siguientePartido = partidosSiguienteFase.firstWhere(
      (partido) =>
          partido['estado'] == 'Pendiente' ||
          partido['equipoLocal'] == null ||
          partido['equipoVisitante'] == null,
      orElse: () => <String, dynamic>{},
    );

    if (siguientePartido.isEmpty) return;

    // Actualizar el siguiente partido con el ganador
    if (siguientePartido['equipoLocal'] == null) {
      siguientePartido['equipoLocal'] = enfrentamientoActual['ganador'];
      siguientePartido['estado'] = 'Programado';
    } else if (siguientePartido['equipoVisitante'] == null) {
      siguientePartido['equipoVisitante'] = enfrentamientoActual['ganador'];
      siguientePartido['estado'] = 'Programado';
    }
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authNotifierProvider);
    final esAdmin = authAsync.value?.rol == RolUsuario.admin;

    return Scaffold(
      appBar: AppBar(
        title: Text('Enfrentamientos - ${widget.torneo.nombre}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getDeporteIcon(widget.torneo.deporte),
                        size: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enfrentamientos',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'Sistema: ${_getMetodoNombre(widget.torneo.metodoEliminacion)}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Lista de enfrentamientos por fase
                Expanded(
                  child: ListView.builder(
                    itemCount: enfrentamientos.length,
                    itemBuilder: (context, index) {
                      final fase = enfrentamientos.keys.elementAt(index);
                      final partidosFase = enfrentamientos[fase]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              fase,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...partidosFase.map((enfrentamiento) => Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: InkWell(
                                  onTap: esAdmin &&
                                          (enfrentamiento['estado'] ==
                                                  'Programado' ||
                                              enfrentamiento['estado'] ==
                                                  'En Progreso')
                                      ? () => _mostrarDialogoEditarResultado(
                                            context,
                                            enfrentamiento,
                                          )
                                      : null,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                enfrentamiento['equipoLocal'] ??
                                                    'Por definir',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: enfrentamiento[
                                                              'equipoLocal'] ==
                                                          null
                                                      ? Colors.grey
                                                      : null,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'VS',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  if (enfrentamiento
                                                      .containsKey('resultado'))
                                                    Text(
                                                      enfrentamiento[
                                                          'resultado']!,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                enfrentamiento[
                                                        'equipoVisitante'] ??
                                                    'Por definir',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: enfrentamiento[
                                                              'equipoVisitante'] ==
                                                          null
                                                      ? Colors.grey
                                                      : null,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              enfrentamiento['fecha']!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: _getColorEstado(
                                                    enfrentamiento['estado']!),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                enfrentamiento['estado']!,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (esAdmin &&
                                            (enfrentamiento['estado'] ==
                                                    'Programado' ||
                                                enfrentamiento['estado'] ==
                                                    'En Progreso'))
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(
                                              'Toca para editar resultado',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarDialogoEditarResultado(
    BuildContext context,
    Map<String, dynamic> enfrentamiento,
  ) {
    showDialog(
      context: context,
      builder: (context) => EditarResultadoDialog(
        enfrentamiento: enfrentamiento,
        onGuardar: _actualizarEnfrentamiento,
      ),
    );
  }

  IconData _getDeporteIcon(Deporte deporte) {
    switch (deporte) {
      case Deporte.futbol:
        return Icons.sports_soccer;
      case Deporte.baloncesto:
        return Icons.sports_basketball;
      case Deporte.voleibol:
        return Icons.sports_volleyball;
    }
  }

  String _getMetodoNombre(MetodoEliminacion metodo) {
    switch (metodo) {
      case MetodoEliminacion.eliminacionDirecta:
        return 'Eliminación Directa';
      case MetodoEliminacion.grupos:
        return 'Grupos';
      case MetodoEliminacion.todosContraTodos:
        return 'Todos contra Todos';
    }
  }

  Color _getColorEstado(String estado) {
    switch (estado) {
      case 'Finalizado':
        return Colors.green;
      case 'Programado':
        return Colors.blue;
      case 'En Progreso':
        return Colors.orange;
      case 'Pendiente':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}

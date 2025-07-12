import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torneos_udea/domain/models/equipo_model.dart';
import 'package:torneos_udea/domain/models/torneo_model.dart';
import 'package:torneos_udea/domain/models/enums.dart';
import 'package:torneos_udea/ui/providers/equipos_provider.dart';
import 'package:torneos_udea/ui/widgets/empty_state_widget.dart';
import 'package:torneos_udea/ui/widgets/error_display_widget.dart';

class GestionEquiposTorneoDialog extends ConsumerStatefulWidget {
  final TorneoModel torneo;

  const GestionEquiposTorneoDialog({
    super.key,
    required this.torneo,
  });

  @override
  ConsumerState<GestionEquiposTorneoDialog> createState() =>
      _GestionEquiposTorneoDialogState();
}

class _GestionEquiposTorneoDialogState
    extends ConsumerState<GestionEquiposTorneoDialog> {
  String? _facultadFiltro;

  @override
  Widget build(BuildContext context) {
    final equiposAsync = ref.watch(equiposNotifierProvider);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildFiltros(context),
            const SizedBox(height: 16),
            Flexible(
              child: equiposAsync.when(
                data: (equipos) {
                  // Filtrar equipos que pertenecen a este torneo
                  final equiposDelTorneo = equipos
                      .where((e) => e.torneoId == widget.torneo.id)
                      .toList();

                  if (equiposDelTorneo.isEmpty) {
                    return _buildEmptyState(context);
                  }

                  // Aplicar filtro de facultad si existe
                  final equiposFiltrados = _facultadFiltro != null
                      ? equiposDelTorneo
                          .where((e) => e.facultad == _facultadFiltro)
                          .toList()
                      : equiposDelTorneo;

                  return _buildListaEquipos(context, equiposFiltrados);
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: ErrorDisplayWidget(
                    error: error,
                    stackTrace: stackTrace,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getColorDeporte(widget.torneo.deporte).withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.groups,
            color: _getColorDeporte(widget.torneo.deporte),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Equipos del Torneo',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                widget.torneo.nombre,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _buildFiltros(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por Facultad',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _facultadFiltro = value.isEmpty ? null : value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return const EmptyStateWidget(
      icon: Icons.groups,
      title: 'No hay equipos',
      message: 'Este torneo aún no tiene equipos asignados',
    );
  }

  Widget _buildListaEquipos(BuildContext context, List<EquipoModel> equipos) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: equipos.length,
      itemBuilder: (context, index) {
        final equipo = equipos[index];
        return Card(
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getColorDeporte(equipo.deporte).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.groups,
                color: _getColorDeporte(equipo.deporte),
                size: 20,
              ),
            ),
            title: Text(equipo.nombre),
            subtitle: Text(equipo.facultad),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmarRemoverEquipo(context, equipo),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
        FilledButton.icon(
          onPressed: () => _mostrarDialogAgregarEquipos(context),
          icon: const Icon(Icons.add),
          label: const Text('Agregar Equipos'),
        ),
      ],
    );
  }

  void _mostrarDialogAgregarEquipos(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _DialogSeleccionarEquipos(
        torneo: widget.torneo,
      ),
    );
  }

  void _confirmarRemoverEquipo(BuildContext context, EquipoModel equipo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover Equipo'),
        content: Text(
          '¿Estás seguro de que deseas remover el equipo "${equipo.nombre}" del torneo?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              try {
                // Actualizar el equipo con torneoId vacío
                final equipoActualizado = equipo.copyWith(torneoId: '');
                await ref
                    .read(equiposNotifierProvider.notifier)
                    .actualizarEquipo(equipoActualizado);

                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Equipo removido exitosamente'),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al remover el equipo: $e'),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }

  Color _getColorDeporte(Deporte deporte) {
    switch (deporte) {
      case Deporte.futbol:
        return Colors.green;
      case Deporte.baloncesto:
        return Colors.orange;
      case Deporte.voleibol:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

class _DialogSeleccionarEquipos extends ConsumerStatefulWidget {
  final TorneoModel torneo;

  const _DialogSeleccionarEquipos({
    required this.torneo,
  });

  @override
  ConsumerState<_DialogSeleccionarEquipos> createState() =>
      _DialogSeleccionarEquiposState();
}

class _DialogSeleccionarEquiposState
    extends ConsumerState<_DialogSeleccionarEquipos> {
  final Set<String> _equiposSeleccionados = {};
  String? _facultadFiltro;

  @override
  Widget build(BuildContext context) {
    final equiposAsync = ref.watch(equiposNotifierProvider);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Agregar Equipos',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Selecciona los equipos que deseas agregar al torneo',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.7),
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Filtrar por Facultad',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _facultadFiltro = value.isEmpty ? null : value;
                });
              },
            ),
            const SizedBox(height: 16),
            Flexible(
              child: equiposAsync.when(
                data: (equipos) {
                  // Filtrar equipos disponibles (mismo deporte y sin torneo)
                  var equiposDisponibles = equipos.where((e) =>
                      e.deporte == widget.torneo.deporte && e.torneoId.isEmpty);

                  // Aplicar filtro de facultad si existe
                  if (_facultadFiltro != null) {
                    equiposDisponibles = equiposDisponibles
                        .where((e) => e.facultad == _facultadFiltro);
                  }

                  final equiposList = equiposDisponibles.toList();

                  if (equiposList.isEmpty) {
                    return const EmptyStateWidget(
                      icon: Icons.groups,
                      title: 'No hay equipos disponibles',
                      message:
                          'No hay equipos que puedan ser agregados al torneo',
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: equiposList.length,
                    itemBuilder: (context, index) {
                      final equipo = equiposList[index];
                      return Card(
                        child: CheckboxListTile(
                          value: _equiposSeleccionados.contains(equipo.id),
                          onChanged: (selected) {
                            setState(() {
                              if (selected ?? false) {
                                _equiposSeleccionados.add(equipo.id);
                              } else {
                                _equiposSeleccionados.remove(equipo.id);
                              }
                            });
                          },
                          title: Text(equipo.nombre),
                          subtitle: Text(equipo.facultad),
                          secondary: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _getColorDeporte(equipo.deporte)
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.groups,
                              color: _getColorDeporte(equipo.deporte),
                              size: 20,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: ErrorDisplayWidget(
                    error: error,
                    stackTrace: stackTrace,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _equiposSeleccionados.isEmpty
                      ? null
                      : () => _agregarEquiposSeleccionados(context),
                  child: const Text('Agregar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _agregarEquiposSeleccionados(BuildContext context) async {
    try {
      final equipos = ref.read(equiposNotifierProvider).value ?? [];
      final equiposParaActualizar = equipos
          .where((e) => _equiposSeleccionados.contains(e.id))
          .map((e) => e.copyWith(torneoId: widget.torneo.id))
          .toList();

      // Actualizar cada equipo
      for (final equipo in equiposParaActualizar) {
        await ref
            .read(equiposNotifierProvider.notifier)
            .actualizarEquipo(equipo);
      }

      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${equiposParaActualizar.length} equipos agregados exitosamente'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al agregar equipos: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Color _getColorDeporte(Deporte deporte) {
    switch (deporte) {
      case Deporte.futbol:
        return Colors.green;
      case Deporte.baloncesto:
        return Colors.orange;
      case Deporte.voleibol:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

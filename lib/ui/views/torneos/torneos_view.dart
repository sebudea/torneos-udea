import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:torneos_udea/domain/models/torneo_model.dart';
import 'package:torneos_udea/domain/models/usuario_model.dart';
import 'package:torneos_udea/ui/providers/auth_provider.dart';
import 'package:torneos_udea/ui/providers/torneos_provider.dart';
import 'package:torneos_udea/ui/widgets/empty_state_widget.dart';
import 'package:torneos_udea/ui/views/torneos/crear_torneo_dialog.dart';
import 'package:torneos_udea/ui/widgets/error_display_widget.dart';

class TorneosView extends ConsumerStatefulWidget {
  const TorneosView({super.key});

  @override
  ConsumerState<TorneosView> createState() => _TorneosViewState();
}

class _TorneosViewState extends ConsumerState<TorneosView> {
  Deporte? _deporteSeleccionado;
  EstadoTorneo? _estadoSeleccionado;

  @override
  Widget build(BuildContext context) {
    final torneosAsync = ref.watch(torneosNotifierProvider);
    final usuario = ref.watch(authNotifierProvider).value;
    final esAdmin = usuario?.rol == RolUsuario.admin;

    return Scaffold(
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
              children: [
                _buildHeader(context),
                const SizedBox(height: 16),
                _buildFiltros(context),
                const SizedBox(height: 16),
                Expanded(
                  child: torneosAsync.when(
                    data: (torneos) {
                      final torneosFiltrados = ref
                          .read(torneosNotifierProvider.notifier)
                          .filtrarTorneos(
                            deporte: _deporteSeleccionado,
                            estado: _estadoSeleccionado,
                          );

                      if (torneosFiltrados.isEmpty) {
                        return _buildEmptyState(context, torneos.isEmpty);
                      }

                      return _buildListaTorneos(
                          context, torneosFiltrados, esAdmin);
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: esAdmin
          ? FloatingActionButton.extended(
              onPressed: () => _mostrarDialogCrearTorneo(context),
              icon: const Icon(Icons.add),
              label: const Text('Nuevo Torneo'),
            )
          : null,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.emoji_events,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Torneos',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                Text(
                  'Gestiona los torneos deportivos',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer
                            .withOpacity(0.8),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltros(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filtros',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildFiltroDeporte(context),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFiltroEstado(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiltroDeporte(BuildContext context) {
    return DropdownButtonFormField<Deporte>(
      value: _deporteSeleccionado,
      decoration: const InputDecoration(
        labelText: 'Deporte',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: [
        const DropdownMenuItem(
          value: null,
          child: Text('Todos'),
        ),
        ...Deporte.values.map((deporte) => DropdownMenuItem(
              value: deporte,
              child: Text(_getDeporteNombre(deporte)),
            )),
      ],
      onChanged: (value) {
        setState(() {
          _deporteSeleccionado = value;
        });
      },
    );
  }

  Widget _buildFiltroEstado(BuildContext context) {
    return DropdownButtonFormField<EstadoTorneo>(
      value: _estadoSeleccionado,
      decoration: const InputDecoration(
        labelText: 'Estado',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: [
        const DropdownMenuItem(
          value: null,
          child: Text('Todos'),
        ),
        ...EstadoTorneo.values.map((estado) => DropdownMenuItem(
              value: estado,
              child: Text(_getEstadoNombre(estado)),
            )),
      ],
      onChanged: (value) {
        setState(() {
          _estadoSeleccionado = value;
        });
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, bool listaVacia) {
    if (listaVacia) {
      return const EmptyStateWidget(
        title: 'No hay torneos',
        message: 'Aún no se han creado torneos. ¡Crea el primero!',
        icon: Icons.emoji_events,
      );
    } else {
      return const EmptyStateWidget(
        title: 'No hay torneos',
        message: 'No se encontraron torneos con los filtros seleccionados.',
        icon: Icons.sports_soccer,
      );
    }
  }

  Widget _buildListaTorneos(
    BuildContext context,
    List<TorneoModel> torneos,
    bool esAdmin,
  ) {
    return ListView.builder(
      itemCount: torneos.length,
      itemBuilder: (context, index) {
        final torneo = torneos[index];
        return _buildTorneoCard(context, torneo, esAdmin);
      },
    );
  }

  Widget _buildTorneoCard(
    BuildContext context,
    TorneoModel torneo,
    bool esAdmin,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _getColorDeporte(torneo.deporte).withOpacity(0.1),
              _getColorDeporte(torneo.deporte).withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getColorDeporte(torneo.deporte).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getIconoDeporte(torneo.deporte),
                    color: _getColorDeporte(torneo.deporte),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        torneo.nombre,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        _getDeporteNombre(torneo.deporte),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.7),
                            ),
                      ),
                    ],
                  ),
                ),
                _buildEstadoChip(context, torneo.estado),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoTorneo(context, torneo),
            if (esAdmin) ...[
              const SizedBox(height: 12),
              _buildAccionesAdmin(context, torneo),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEstadoChip(BuildContext context, EstadoTorneo estado) {
    Color color;
    String texto;

    switch (estado) {
      case EstadoTorneo.registro:
        color = Colors.blue;
        texto = 'Registro';
        break;
      case EstadoTorneo.enProgreso:
        color = Colors.orange;
        texto = 'En Progreso';
        break;
      case EstadoTorneo.finalizado:
        color = Colors.green;
        texto = 'Finalizado';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoTorneo(BuildContext context, TorneoModel torneo) {
    return Column(
      children: [
        _buildInfoRow('Equipos', '${torneo.cantidadEquipos} equipos'),
        _buildInfoRow('Método', _getMetodoNombre(torneo.metodoEliminacion)),
        _buildInfoRow(
            'Registro',
            _formatearFecha(
                torneo.fechaInicioRegistro, torneo.fechaFinRegistro)),
        _buildInfoRow('Torneo',
            _formatearFecha(torneo.fechaInicioTorneo, torneo.fechaFinTorneo)),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccionesAdmin(BuildContext context, TorneoModel torneo) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _editarTorneo(context, torneo),
            icon: const Icon(Icons.edit, size: 16),
            label: const Text('Editar'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _eliminarTorneo(context, torneo),
            icon: const Icon(Icons.delete, size: 16),
            label: const Text('Eliminar'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  // Métodos auxiliares
  String _getDeporteNombre(Deporte deporte) {
    switch (deporte) {
      case Deporte.futbol:
        return 'Fútbol';
      case Deporte.baloncesto:
        return 'Baloncesto';
      case Deporte.voleibol:
        return 'Voleibol';
    }
  }

  IconData _getIconoDeporte(Deporte deporte) {
    switch (deporte) {
      case Deporte.futbol:
        return Icons.sports_soccer;
      case Deporte.baloncesto:
        return Icons.sports_basketball;
      case Deporte.voleibol:
        return Icons.sports_volleyball;
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
    }
  }

  String _getEstadoNombre(EstadoTorneo estado) {
    switch (estado) {
      case EstadoTorneo.registro:
        return 'Registro';
      case EstadoTorneo.enProgreso:
        return 'En Progreso';
      case EstadoTorneo.finalizado:
        return 'Finalizado';
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

  String _formatearFecha(DateTime inicio, DateTime fin) {
    final formatter = DateFormat('dd/MM/yyyy');
    return '${formatter.format(inicio)} - ${formatter.format(fin)}';
  }

  // Métodos de acción
  void _mostrarDialogCrearTorneo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CrearTorneoDialog(),
    );
  }

  void _editarTorneo(BuildContext context, TorneoModel torneo) {
    // TODO: Implementar edición de torneo
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de editar torneo en desarrollo')),
    );
  }

  void _eliminarTorneo(BuildContext context, TorneoModel torneo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Torneo'),
        content:
            Text('¿Estás seguro de que deseas eliminar "${torneo.nombre}"?'),
        actions: [
          FilledButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          OutlinedButton(
            child: const Text('Eliminar'),
            onPressed: () {
              ref
                  .read(torneosNotifierProvider.notifier)
                  .eliminarTorneo(torneo.id);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Torneo eliminado')),
              );
            },
          ),
        ],
      ),
    );
  }
}

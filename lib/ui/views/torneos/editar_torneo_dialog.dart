import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torneos_udea/domain/models/torneo_model.dart';
import 'package:torneos_udea/ui/providers/torneos_provider.dart';

class EditarTorneoDialog extends ConsumerStatefulWidget {
  final TorneoModel torneo;

  const EditarTorneoDialog({
    super.key,
    required this.torneo,
  });

  @override
  ConsumerState<EditarTorneoDialog> createState() => _EditarTorneoDialogState();
}

class _EditarTorneoDialogState extends ConsumerState<EditarTorneoDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late Deporte _deporteSeleccionado;
  late MetodoEliminacion _metodoSeleccionado;
  late TextEditingController _cantidadEquiposController;
  late EstadoTorneo _estadoSeleccionado;
  late DateTime _fechaInicioRegistro;
  late DateTime _fechaFinRegistro;
  late DateTime _fechaInicioTorneo;
  late DateTime _fechaFinTorneo;

  @override
  void initState() {
    super.initState();
    // Inicializar controladores con los valores del torneo
    _nombreController = TextEditingController(text: widget.torneo.nombre);
    _deporteSeleccionado = widget.torneo.deporte;
    _metodoSeleccionado = widget.torneo.metodoEliminacion;
    _cantidadEquiposController = TextEditingController(
      text: widget.torneo.cantidadEquipos.toString(),
    );
    _estadoSeleccionado = widget.torneo.estado;
    _fechaInicioRegistro = widget.torneo.fechaInicioRegistro;
    _fechaFinRegistro = widget.torneo.fechaFinRegistro;
    _fechaInicioTorneo = widget.torneo.fechaInicioTorneo;
    _fechaFinTorneo = widget.torneo.fechaFinTorneo;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _cantidadEquiposController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Editar Torneo',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Torneo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<Deporte>(
                  value: _deporteSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Deporte',
                    border: OutlineInputBorder(),
                  ),
                  items: Deporte.values.map((deporte) {
                    return DropdownMenuItem(
                      value: deporte,
                      child: Text(_getDeporteNombre(deporte)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _deporteSeleccionado = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<MetodoEliminacion>(
                  value: _metodoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Método de Eliminación',
                    border: OutlineInputBorder(),
                  ),
                  items: MetodoEliminacion.values.map((metodo) {
                    return DropdownMenuItem(
                      value: metodo,
                      child: Text(_getMetodoNombre(metodo)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _metodoSeleccionado = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cantidadEquiposController,
                  decoration: const InputDecoration(
                    labelText: 'Cantidad de Equipos',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la cantidad de equipos';
                    }
                    final numero = int.tryParse(value);
                    if (numero == null || numero < 2) {
                      return 'Debe ser un número mayor a 1';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<EstadoTorneo>(
                  value: _estadoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Estado del Torneo',
                    border: OutlineInputBorder(),
                  ),
                  items: EstadoTorneo.values.map((estado) {
                    return DropdownMenuItem(
                      value: estado,
                      child: Text(_getEstadoNombre(estado)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _estadoSeleccionado = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                _buildDateRangePicker(
                  context,
                  'Período de Registro',
                  _fechaInicioRegistro,
                  _fechaFinRegistro,
                  (inicio, fin) {
                    setState(() {
                      _fechaInicioRegistro = inicio;
                      _fechaFinRegistro = fin;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildDateRangePicker(
                  context,
                  'Período del Torneo',
                  _fechaInicioTorneo,
                  _fechaFinTorneo,
                  (inicio, fin) {
                    setState(() {
                      _fechaInicioTorneo = inicio;
                      _fechaFinTorneo = fin;
                    });
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 16),
                    FilledButton(
                      onPressed: _guardarTorneo,
                      child: const Text('Guardar Cambios'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateRangePicker(
    BuildContext context,
    String label,
    DateTime fechaInicio,
    DateTime fechaFin,
    void Function(DateTime inicio, DateTime fin) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
                  final fecha = await showDatePicker(
                    context: context,
                    initialDate: fechaInicio,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                  );
                  if (fecha != null) {
                    onChanged(fecha, fechaFin);
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  'Inicio: ${fechaInicio.day}/${fechaInicio.month}/${fechaInicio.year}',
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
                  final fecha = await showDatePicker(
                    context: context,
                    initialDate: fechaFin,
                    firstDate: fechaInicio,
                    lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                  );
                  if (fecha != null) {
                    onChanged(fechaInicio, fecha);
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  'Fin: ${fechaFin.day}/${fechaFin.month}/${fechaFin.year}',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _guardarTorneo() {
    if (!_formKey.currentState!.validate()) return;

    // Validar fechas
    if (_fechaFinRegistro.isBefore(_fechaInicioRegistro)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'La fecha de fin de registro debe ser posterior a la de inicio'),
        ),
      );
      return;
    }

    if (_fechaFinTorneo.isBefore(_fechaInicioTorneo)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'La fecha de fin del torneo debe ser posterior a la de inicio'),
        ),
      );
      return;
    }

    if (_fechaInicioTorneo.isBefore(_fechaFinRegistro)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('El torneo debe comenzar después del período de registro'),
        ),
      );
      return;
    }

    final torneoActualizado = TorneoModel(
      id: widget.torneo.id,
      nombre: _nombreController.text,
      deporte: _deporteSeleccionado,
      metodoEliminacion: _metodoSeleccionado,
      cantidadEquipos: int.parse(_cantidadEquiposController.text),
      estado: _estadoSeleccionado,
      fechaInicioRegistro: _fechaInicioRegistro,
      fechaFinRegistro: _fechaFinRegistro,
      fechaInicioTorneo: _fechaInicioTorneo,
      fechaFinTorneo: _fechaFinTorneo,
      createdAt: widget.torneo.createdAt,
      updatedAt: DateTime.now(),
      createdBy: widget.torneo.createdBy,
    );

    ref
        .read(torneosNotifierProvider.notifier)
        .actualizarTorneo(torneoActualizado);

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Torneo "${torneoActualizado.nombre}" actualizado exitosamente'),
      ),
    );
  }

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
}

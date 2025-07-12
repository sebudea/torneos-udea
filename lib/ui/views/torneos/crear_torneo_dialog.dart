import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:torneos_udea/domain/models/enums.dart';
import 'package:torneos_udea/domain/models/torneo_model.dart';
import 'package:torneos_udea/ui/providers/auth_provider.dart';
import 'package:torneos_udea/ui/providers/torneos_provider.dart';

class CrearTorneoDialog extends ConsumerStatefulWidget {
  const CrearTorneoDialog({super.key});

  @override
  ConsumerState<CrearTorneoDialog> createState() => _CrearTorneoDialogState();
}

class _CrearTorneoDialogState extends ConsumerState<CrearTorneoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _cantidadEquiposController = TextEditingController();

  Deporte _deporteSeleccionado = Deporte.futbol;
  MetodoEliminacion _metodoSeleccionado = MetodoEliminacion.eliminacionDirecta;
  EstadoTorneo _estadoSeleccionado = EstadoTorneo.registro;

  DateTime _fechaInicioRegistro = DateTime.now();
  DateTime _fechaFinRegistro = DateTime.now().add(const Duration(days: 7));
  DateTime _fechaInicioTorneo = DateTime.now().add(const Duration(days: 14));
  DateTime _fechaFinTorneo = DateTime.now().add(const Duration(days: 30));

  @override
  void dispose() {
    _nombreController.dispose();
    _cantidadEquiposController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear Nuevo Torneo'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Torneo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el nombre del torneo';
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
                  items: Deporte.values
                      .map((deporte) => DropdownMenuItem(
                            value: deporte,
                            child: Text(_getDeporteNombre(deporte)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _deporteSeleccionado = value!;
                    });
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
                    final cantidad = int.tryParse(value);
                    if (cantidad == null || cantidad < 2) {
                      return 'Debe ser un número mayor a 1';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<MetodoEliminacion>(
                  value: _metodoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Método de Eliminación',
                    border: OutlineInputBorder(),
                  ),
                  items: MetodoEliminacion.values
                      .map((metodo) => DropdownMenuItem(
                            value: metodo,
                            child: Text(_getMetodoNombre(metodo)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _metodoSeleccionado = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<EstadoTorneo>(
                  value: _estadoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Estado',
                    border: OutlineInputBorder(),
                  ),
                  items: EstadoTorneo.values
                      .map((estado) => DropdownMenuItem(
                            value: estado,
                            child: Text(_getEstadoNombre(estado)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _estadoSeleccionado = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildFechaSelector(
                  'Inicio Registro',
                  _fechaInicioRegistro,
                  (fecha) => setState(() => _fechaInicioRegistro = fecha),
                ),
                const SizedBox(height: 8),
                _buildFechaSelector(
                  'Fin Registro',
                  _fechaFinRegistro,
                  (fecha) => setState(() => _fechaFinRegistro = fecha),
                ),
                const SizedBox(height: 8),
                _buildFechaSelector(
                  'Inicio Torneo',
                  _fechaInicioTorneo,
                  (fecha) => setState(() => _fechaInicioTorneo = fecha),
                ),
                const SizedBox(height: 8),
                _buildFechaSelector(
                  'Fin Torneo',
                  _fechaFinTorneo,
                  (fecha) => setState(() => _fechaFinTorneo = fecha),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        FilledButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FilledButton(
          child: const Text('Crear'),
          onPressed: _crearTorneo,
        ),
      ],
    );
  }

  Widget _buildFechaSelector(
    String label,
    DateTime fecha,
    Function(DateTime) onChanged,
  ) {
    return InkWell(
      onTap: () async {
        final fechaSeleccionada = await showDatePicker(
          context: context,
          initialDate: fecha,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (fechaSeleccionada != null) {
          onChanged(fechaSeleccionada);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 16),
            const SizedBox(width: 8),
            Text(
              '$label: ${DateFormat('dd/MM/yyyy').format(fecha)}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  void _crearTorneo() {
    if (_formKey.currentState!.validate()) {
      final usuario = ref.read(authNotifierProvider).value;
      if (usuario == null) return;

      final nuevoTorneo = TorneoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nombre: _nombreController.text,
        deporte: _deporteSeleccionado,
        metodoEliminacion: _metodoSeleccionado,
        cantidadEquipos: int.parse(_cantidadEquiposController.text),
        estado: _estadoSeleccionado,
        fechaInicioRegistro: _fechaInicioRegistro,
        fechaFinRegistro: _fechaFinRegistro,
        fechaInicioTorneo: _fechaInicioTorneo,
        fechaFinTorneo: _fechaFinTorneo,
        createdAt: DateTime.now(), // This will be overwritten by Firestore
        updatedAt: DateTime.now(), // This will be overwritten by Firestore
        createdBy: usuario.id,
      );

      ref.read(torneosNotifierProvider.notifier).agregarTorneo(nuevoTorneo);

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Torneo "${nuevoTorneo.nombre}" creado exitosamente'),
        ),
      );
    }
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

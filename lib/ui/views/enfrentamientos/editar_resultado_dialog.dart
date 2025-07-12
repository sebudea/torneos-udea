import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditarResultadoDialog extends StatefulWidget {
  final Map<String, dynamic> enfrentamiento;
  final Function(Map<String, dynamic>) onGuardar;

  const EditarResultadoDialog({
    super.key,
    required this.enfrentamiento,
    required this.onGuardar,
  });

  @override
  State<EditarResultadoDialog> createState() => _EditarResultadoDialogState();
}

class _EditarResultadoDialogState extends State<EditarResultadoDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _resultadoLocalController;
  late TextEditingController _resultadoVisitanteController;
  bool _partidoFinalizado = false;

  @override
  void initState() {
    super.initState();
    // Si ya hay resultado, parsearlo
    if (widget.enfrentamiento.containsKey('resultado')) {
      final resultados = widget.enfrentamiento['resultado']!.split(' - ');
      _resultadoLocalController = TextEditingController(text: resultados[0]);
      _resultadoVisitanteController =
          TextEditingController(text: resultados[1]);
    } else {
      _resultadoLocalController = TextEditingController();
      _resultadoVisitanteController = TextEditingController();
    }
    _partidoFinalizado = widget.enfrentamiento['estado'] == 'Finalizado';
  }

  @override
  void dispose() {
    _resultadoLocalController.dispose();
    _resultadoVisitanteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Resultado'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.enfrentamiento['equipoLocal']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _resultadoLocalController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Marcador',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Requerido';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'VS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.enfrentamiento['equipoVisitante']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _resultadoVisitanteController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Marcador',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Requerido';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _partidoFinalizado,
              onChanged: (value) {
                setState(() {
                  _partidoFinalizado = value!;
                });
              },
              title: const Text('Partido finalizado'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final resultadoActualizado = {
                ...widget.enfrentamiento,
                'resultado':
                    '${_resultadoLocalController.text} - ${_resultadoVisitanteController.text}',
                'estado': _partidoFinalizado ? 'Finalizado' : 'En Progreso',
                // Determinar el ganador
                'ganador': _determinarGanador(
                  int.parse(_resultadoLocalController.text),
                  int.parse(_resultadoVisitanteController.text),
                  widget.enfrentamiento['equipoLocal'],
                  widget.enfrentamiento['equipoVisitante'],
                ),
              };
              widget.onGuardar(resultadoActualizado);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }

  String? _determinarGanador(
    int marcadorLocal,
    int marcadorVisitante,
    String equipoLocal,
    String equipoVisitante,
  ) {
    if (!_partidoFinalizado) return null;
    if (marcadorLocal > marcadorVisitante) return equipoLocal;
    if (marcadorVisitante > marcadorLocal) return equipoVisitante;
    return null; // Empate
  }
}

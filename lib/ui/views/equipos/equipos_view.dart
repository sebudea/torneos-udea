import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:torneos_udea/domain/models/equipo_model.dart';
import 'package:torneos_udea/domain/models/usuario_model.dart';
import 'package:torneos_udea/ui/providers/auth_provider.dart';
import 'package:torneos_udea/ui/providers/equipos_provider.dart';
import 'package:torneos_udea/ui/widgets/empty_state_widget.dart';
import 'package:torneos_udea/ui/widgets/error_display_widget.dart';

// Lista de facultades de la UdeA
const List<String> facultades = [
  'Artes',
  'Ciencias Agrarias',
  'Ciencias Económicas',
  'Ciencias Exactas y Naturales',
  'Ciencias Farmacéuticas y Alimentarias',
  'Ciencias Sociales y Humanas',
  'Comunicaciones y Filología',
  'Derecho y Ciencias Políticas',
  'Educación',
  'Enfermería',
  'Ingeniería',
  'Medicina',
  'Odontología',
  'Salud Pública',
];

// Número de integrantes por deporte
const Map<String, int> integrantesPorDeporte = {
  'futbol': 11,
  'baloncesto': 5,
  'voleibol': 6,
};

class EquiposView extends ConsumerStatefulWidget {
  const EquiposView({super.key});

  @override
  ConsumerState<EquiposView> createState() => _EquiposViewState();
}

class _EquiposViewState extends ConsumerState<EquiposView> {
  Deporte? _deporteSeleccionado;
  String? _facultadSeleccionada;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Iniciar un timer corto para dar tiempo a la autenticación
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authNotifierProvider);

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
          child: _isLoading
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Cargando...'),
                    ],
                  ),
                )
              : authAsync.when(
                  data: (usuario) {
                    if (usuario == null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.go('/auth?from=/equipos');
                      });
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Verificando autenticación...'),
                          ],
                        ),
                      );
                    }
                    return _buildEquiposContent(context, usuario);
                  },
                  loading: () => const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Verificando autenticación...'),
                      ],
                    ),
                  ),
                  error: (error, stackTrace) => Center(
                    child: ErrorDisplayWidget(
                      error: error,
                      stackTrace: stackTrace,
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButton: !_isLoading
          ? authAsync.when(
              data: (usuario) {
                if (usuario?.rol == RolUsuario.admin) {
                  return FloatingActionButton.extended(
                    onPressed: () => _mostrarDialogCrearEquipo(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Nuevo Equipo'),
                  );
                }
                return null;
              },
              loading: () => null,
              error: (error, stackTrace) => null,
            )
          : null,
    );
  }

  Widget _buildEquiposContent(BuildContext context, UsuarioModel usuario) {
    final equiposAsync = ref.watch(equiposNotifierProvider);
    final esAdmin = usuario.rol == RolUsuario.admin;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 16),
          _buildFiltros(context),
          const SizedBox(height: 16),
          Expanded(
            child: equiposAsync.when(
              data: (equipos) {
                final equiposFiltrados =
                    ref.read(equiposNotifierProvider.notifier).filtrarEquipos(
                          deporte: _deporteSeleccionado,
                          facultad: _facultadSeleccionada,
                        );

                if (equiposFiltrados.isEmpty) {
                  return _buildEmptyState(context, equipos.isEmpty);
                }

                return _buildListaEquipos(context, equiposFiltrados, esAdmin);
              },
              loading: () => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Cargando equipos...'),
                  ],
                ),
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
              Icons.groups_2,
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
                  'Equipos',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                Text(
                  'Gestiona los equipos deportivos',
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtros',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<Deporte>(
                    value: _deporteSeleccionado,
                    decoration: const InputDecoration(
                      labelText: 'Deporte',
                      border: OutlineInputBorder(),
                    ),
                    items: Deporte.values.map((deporte) {
                      return DropdownMenuItem(
                        value: deporte,
                        child: Text(deporte.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _deporteSeleccionado = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Facultad',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _facultadSeleccionada = value.isEmpty ? null : value;
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

  Widget _buildEmptyState(BuildContext context, bool noHayEquipos) {
    return EmptyStateWidget(
      icon: Icons.groups_2,
      title: noHayEquipos ? 'No hay equipos' : 'No hay resultados',
      message: noHayEquipos
          ? 'Aún no se han creado equipos'
          : 'No hay equipos que coincidan con los filtros seleccionados',
    );
  }

  Widget _buildListaEquipos(
    BuildContext context,
    List<EquipoModel> equipos,
    bool esAdmin,
  ) {
    return ListView.builder(
      itemCount: equipos.length,
      itemBuilder: (context, index) {
        final equipo = equipos[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 4,
          child: InkWell(
            onTap: () => _mostrarDetallesEquipo(context, equipo),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _getColorDeporte(equipo.deporte).withOpacity(0.1),
                    _getColorDeporte(equipo.deporte).withOpacity(0.05),
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
                          color:
                              _getColorDeporte(equipo.deporte).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getIconoDeporte(equipo.deporte),
                          color: _getColorDeporte(equipo.deporte),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              equipo.nombre,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              equipo.facultad,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      _buildEquipoChip(context, equipo),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildInfoEquipo(context, equipo),
                  if (esAdmin) ...[
                    const SizedBox(height: 12),
                    _buildAccionesAdmin(context, equipo),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEquipoChip(BuildContext context, EquipoModel equipo) {
    final color = _getColorDeporte(equipo.deporte);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        equipo.deporte.name,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoEquipo(BuildContext context, EquipoModel equipo) {
    return Column(
      children: [
        _buildInfoRow('Capitán', equipo.capitan),
        _buildInfoRow('Integrantes',
            '${equipo.integrantes.length}/${equipo.numeroIntegrantes}'),
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

  Widget _buildAccionesAdmin(BuildContext context, EquipoModel equipo) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _mostrarDialogEditarEquipo(context, equipo),
            icon: const Icon(Icons.edit, size: 16),
            label: const Text('Editar'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _eliminarEquipo(context, equipo),
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

  IconData _getIconoDeporte(Deporte deporte) {
    switch (deporte) {
      case Deporte.futbol:
        return Icons.groups;
      case Deporte.baloncesto:
        return Icons.groups;
      case Deporte.voleibol:
        return Icons.groups;
    }
  }

  void _mostrarDialogCrearEquipo(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String nombre = '';
    String? facultad;
    Deporte? deporte;
    String capitan = '';
    List<String> integrantes = [];
    final integrantesControllers = <TextEditingController>[];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          // Obtener el número de jugadores requeridos para el deporte seleccionado
          final deporteSeleccionado =
              deporte; // Cache the value to avoid null checks
          final numJugadoresRequeridos = deporteSeleccionado != null
              ? integrantesPorDeporte[deporteSeleccionado.name.toLowerCase()]!
              : 0;

          // Crear o actualizar los controladores según el deporte seleccionado
          if (deporteSeleccionado != null) {
            final numJugadoresExtra = numJugadoresRequeridos -
                1; // Restamos 1 porque el capitán ya cuenta como jugador

            // Asegurarnos de tener el número correcto de controladores
            while (integrantesControllers.length < numJugadoresExtra) {
              integrantesControllers.add(TextEditingController());
            }
            while (integrantesControllers.length > numJugadoresExtra) {
              integrantesControllers.removeLast().dispose();
            }
          } else {
            // Limpiar controladores si no hay deporte seleccionado
            for (var controller in integrantesControllers) {
              controller.dispose();
            }
            integrantesControllers.clear();
          }

          return AlertDialog(
            title: const Text('Crear Equipo'),
            content: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nombre del equipo',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El nombre es requerido';
                        }
                        return null;
                      },
                      onSaved: (value) => nombre = value!,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Facultad',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                      ),
                      isExpanded: true,
                      items: facultades.map((f) {
                        return DropdownMenuItem(
                          value: f,
                          child: Text(
                            f,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      value: facultad,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'La facultad es requerida';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() => facultad = value),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Deporte>(
                      decoration: const InputDecoration(
                        labelText: 'Deporte',
                        border: OutlineInputBorder(),
                      ),
                      items: Deporte.values.map((d) {
                        return DropdownMenuItem(
                          value: d,
                          child: Text(d.name),
                        );
                      }).toList(),
                      value: deporte,
                      validator: (value) {
                        if (value == null) {
                          return 'El deporte es requerido';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() {
                        deporte = value;
                        capitan = '';
                        integrantes.clear();
                      }),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Capitán',
                        border: OutlineInputBorder(),
                        helperText:
                            'El capitán será el primer integrante del equipo',
                        prefixIcon: Tooltip(
                          message:
                              'El capitán cuenta como un jugador del equipo',
                          child: Icon(Icons.star),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El capitán es requerido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          capitan = value;
                          // Actualizar la lista de integrantes
                          if (integrantes.isEmpty) {
                            integrantes.add(value);
                          } else {
                            integrantes[0] = value;
                          }
                        });
                      },
                    ),
                    if (deporteSeleccionado != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Integrantes (${integrantes.length}/$numJugadoresRequeridos)',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      // Mostrar el capitán como primer integrante
                      Card(
                        child: ListTile(
                          leading: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          title: Text(capitan.isEmpty
                              ? 'Capitán (pendiente)'
                              : capitan),
                          trailing: const Tooltip(
                            message: 'El capitán no se puede eliminar',
                            child: Icon(Icons.star),
                          ),
                        ),
                      ),
                      // Mostrar campos para el resto de integrantes
                      ...List.generate(
                        numJugadoresRequeridos - 1,
                        (index) {
                          final playerIndex =
                              index + 1; // +1 porque el capitán es 0
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              controller: integrantesControllers[index],
                              decoration: InputDecoration(
                                labelText: 'Jugador ${playerIndex + 1}',
                                border: const OutlineInputBorder(),
                                prefixIcon: Container(
                                  width: 24,
                                  height: 24,
                                  margin: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.5),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${playerIndex + 1}',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El nombre del jugador es requerido';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  // Actualizar la lista de integrantes
                                  while (integrantes.length <= playerIndex) {
                                    integrantes.add('');
                                  }
                                  integrantes[playerIndex] = value;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    // Validar número de integrantes
                    if (deporteSeleccionado != null &&
                        integrantes.length != numJugadoresRequeridos) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Un equipo de ${deporteSeleccionado.name} debe tener exactamente $numJugadoresRequeridos integrantes',
                          ),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                      );
                      return;
                    }

                    final equipo = EquipoModel(
                      id: '', // Se asignará en Firestore
                      nombre: nombre,
                      torneoId: '', // TODO: Implementar selección de torneo
                      deporte: deporteSeleccionado!,
                      capitan: capitan,
                      facultad: facultad!,
                      integrantes: [
                        capitan,
                        ...integrantesControllers
                            .map((c) => c.text)
                            .where((text) => text.isNotEmpty)
                      ],
                      createdAt: DateTime.now(),
                    );

                    try {
                      await ref
                          .read(equiposNotifierProvider.notifier)
                          .crearEquipo(equipo);

                      if (context.mounted) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Equipo creado exitosamente'),
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error al crear el equipo: $e'),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                        );
                      }
                    }
                  }
                },
                child: const Text('Crear'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _mostrarDialogEditarEquipo(BuildContext context, EquipoModel equipo) {
    final formKey = GlobalKey<FormState>();
    String nombre = equipo.nombre;
    String? facultad = equipo.facultad;
    Deporte deporte = equipo.deporte;
    String capitan = equipo.capitan;
    List<String> integrantes = equipo.integrantes;
    final integrantesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Editar Equipo'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: nombre,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del equipo',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El nombre es requerido';
                      }
                      return null;
                    },
                    onSaved: (value) => nombre = value!,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: facultad,
                    decoration: const InputDecoration(
                      labelText: 'Facultad',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                    ),
                    isExpanded: true,
                    items: facultades.map((f) {
                      return DropdownMenuItem(
                        value: f,
                        child: Text(
                          f,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La facultad es requerida';
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() => facultad = value),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<Deporte>(
                    value: deporte,
                    decoration: const InputDecoration(
                      labelText: 'Deporte',
                      border: OutlineInputBorder(),
                    ),
                    items: Deporte.values.map((d) {
                      return DropdownMenuItem(
                        value: d,
                        child: Text(d.name),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'El deporte es requerido';
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() {
                      deporte = value!;
                      // Limpiar integrantes si cambia el deporte
                      integrantes.clear();
                      capitan = '';
                    }),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: capitan,
                    decoration: const InputDecoration(
                      labelText: 'Capitán',
                      border: OutlineInputBorder(),
                      helperText:
                          'El capitán será el primer integrante del equipo',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El capitán es requerido';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        capitan = value;
                        // Si hay integrantes, actualizar el primero
                        if (integrantes.isNotEmpty) {
                          integrantes[0] = value;
                        } else {
                          integrantes.add(value);
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Integrantes (${integrantes.length}/${integrantesPorDeporte[deporte.name.toLowerCase()]})',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ...integrantes.asMap().entries.map(
                        (entry) => Card(
                          child: ListTile(
                            leading: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  '${entry.key + 1}',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(entry.value),
                            trailing: entry.key == 0
                                ? const Tooltip(
                                    message: 'Capitán del equipo',
                                    child: Icon(Icons.star),
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        integrantes.removeAt(entry.key);
                                      });
                                    },
                                  ),
                          ),
                        ),
                      ),
                  if (integrantes.length <
                      integrantesPorDeporte[deporte.name.toLowerCase()]!) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: integrantesController,
                            decoration: const InputDecoration(
                              labelText: 'Nombre del integrante',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            final nombre = integrantesController.text.trim();
                            if (nombre.isNotEmpty) {
                              setState(() {
                                integrantes.add(nombre);
                                integrantesController.clear();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  // Validar número de integrantes
                  if (integrantes.length !=
                      integrantesPorDeporte[deporte.name.toLowerCase()]) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Un equipo de ${deporte.name} debe tener exactamente ${integrantesPorDeporte[deporte.name.toLowerCase()]} integrantes',
                        ),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                    return;
                  }

                  final equipoActualizado = equipo.copyWith(
                    nombre: nombre,
                    deporte: deporte,
                    capitan: capitan,
                    facultad: facultad!,
                    integrantes: integrantes,
                  );

                  try {
                    await ref
                        .read(equiposNotifierProvider.notifier)
                        .actualizarEquipo(equipoActualizado);

                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Equipo actualizado exitosamente'),
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error al actualizar el equipo: $e'),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                      );
                    }
                  }
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDetallesEquipo(BuildContext context, EquipoModel equipo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getColorDeporte(equipo.deporte).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getIconoDeporte(equipo.deporte),
                color: _getColorDeporte(equipo.deporte),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    equipo.nombre,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    equipo.facultad,
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
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetallesInfoRow('Deporte', equipo.deporte.name),
              const SizedBox(height: 8),
              _buildDetallesInfoRow('Facultad', equipo.facultad),
              const SizedBox(height: 8),
              _buildDetallesInfoRow('Capitán', equipo.capitan),
              const SizedBox(height: 16),
              Text(
                'Integrantes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              ...equipo.integrantes.asMap().entries.map((entry) => Card(
                    child: ListTile(
                      leading: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            '${entry.key + 1}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      title: Text(entry.value),
                      trailing: entry.key == 0
                          ? const Tooltip(
                              message: 'Capitán del equipo',
                              child: Icon(Icons.star),
                            )
                          : null,
                    ),
                  )),
              if (!equipo.tieneIntegrantesValidos)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    equipo.mensajeValidacion,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetallesInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }

  void _eliminarEquipo(BuildContext context, EquipoModel equipo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Equipo'),
        content: Text(
            '¿Estás seguro de que deseas eliminar el equipo "${equipo.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              try {
                await ref
                    .read(equiposNotifierProvider.notifier)
                    .eliminarEquipo(equipo.id);
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Equipo eliminado exitosamente'),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al eliminar el equipo: $e'),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

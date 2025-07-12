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
  late Map<String, dynamic> datosGrupos;
  late Map<String, List<Map<String, dynamic>>> enfrentamientosFaseGrupos;
  late Map<String, List<Map<String, dynamic>>> enfrentamientos;
  int grupoSeleccionado = 0;

  @override
  void initState() {
    super.initState();

    // Datos simulados de grupos
    datosGrupos = {
      'grupos': ['Grupo A', 'Grupo B', 'Grupo C', 'Grupo D'],
      'tablas': {
        'Grupo A': [
          {
            'equipo': 'Equipo A',
            'pj': 3,
            'pg': 2,
            'pe': 1,
            'pp': 0,
            'gf': 7,
            'gc': 2,
            'pts': 7,
          },
          {
            'equipo': 'Equipo B',
            'pj': 3,
            'pg': 2,
            'pe': 0,
            'pp': 1,
            'gf': 5,
            'gc': 3,
            'pts': 6,
          },
          {
            'equipo': 'Equipo C',
            'pj': 3,
            'pg': 1,
            'pe': 1,
            'pp': 1,
            'gf': 4,
            'gc': 4,
            'pts': 4,
          },
          {
            'equipo': 'Equipo D',
            'pj': 3,
            'pg': 0,
            'pe': 0,
            'pp': 3,
            'gf': 1,
            'gc': 8,
            'pts': 0,
          },
        ],
        'Grupo B': [
          {
            'equipo': 'Equipo E',
            'pj': 3,
            'pg': 3,
            'pe': 0,
            'pp': 0,
            'gf': 8,
            'gc': 2,
            'pts': 9,
          },
          {
            'equipo': 'Equipo F',
            'pj': 3,
            'pg': 1,
            'pe': 1,
            'pp': 1,
            'gf': 4,
            'gc': 4,
            'pts': 4,
          },
          {
            'equipo': 'Equipo G',
            'pj': 3,
            'pg': 1,
            'pe': 0,
            'pp': 2,
            'gf': 3,
            'gc': 5,
            'pts': 3,
          },
          {
            'equipo': 'Equipo H',
            'pj': 3,
            'pg': 0,
            'pe': 1,
            'pp': 2,
            'gf': 2,
            'gc': 6,
            'pts': 1,
          },
        ],
        'Grupo C': [
          {
            'equipo': 'Equipo I',
            'pj': 3,
            'pg': 2,
            'pe': 1,
            'pp': 0,
            'gf': 6,
            'gc': 2,
            'pts': 7,
          },
          {
            'equipo': 'Equipo J',
            'pj': 3,
            'pg': 2,
            'pe': 0,
            'pp': 1,
            'gf': 5,
            'gc': 3,
            'pts': 6,
          },
          {
            'equipo': 'Equipo K',
            'pj': 3,
            'pg': 0,
            'pe': 2,
            'pp': 1,
            'gf': 3,
            'gc': 5,
            'pts': 2,
          },
          {
            'equipo': 'Equipo L',
            'pj': 3,
            'pg': 0,
            'pe': 1,
            'pp': 2,
            'gf': 2,
            'gc': 6,
            'pts': 1,
          },
        ],
        'Grupo D': [
          {
            'equipo': 'Equipo M',
            'pj': 3,
            'pg': 3,
            'pe': 0,
            'pp': 0,
            'gf': 9,
            'gc': 1,
            'pts': 9,
          },
          {
            'equipo': 'Equipo N',
            'pj': 3,
            'pg': 1,
            'pe': 1,
            'pp': 1,
            'gf': 4,
            'gc': 4,
            'pts': 4,
          },
          {
            'equipo': 'Equipo O',
            'pj': 3,
            'pg': 1,
            'pe': 0,
            'pp': 2,
            'gf': 3,
            'gc': 6,
            'pts': 3,
          },
          {
            'equipo': 'Equipo P',
            'pj': 3,
            'pg': 0,
            'pe': 1,
            'pp': 2,
            'gf': 2,
            'gc': 7,
            'pts': 1,
          },
        ],
      },
    };

    enfrentamientosFaseGrupos = {
      'Grupo A': [
        {
          'id': '1',
          'equipoLocal': 'Equipo A',
          'equipoVisitante': 'Equipo B',
          'fecha': '2024-05-15 14:00',
          'estado': 'Finalizado',
          'resultado': '2 - 1',
        },
        {
          'id': '2',
          'equipoLocal': 'Equipo C',
          'equipoVisitante': 'Equipo D',
          'fecha': '2024-05-15 16:00',
          'estado': 'Finalizado',
          'resultado': '3 - 0',
        },
        {
          'id': '3',
          'equipoLocal': 'Equipo A',
          'equipoVisitante': 'Equipo C',
          'fecha': '2024-05-16 14:00',
          'estado': 'Finalizado',
          'resultado': '2 - 2',
        },
        {
          'id': '4',
          'equipoLocal': 'Equipo B',
          'equipoVisitante': 'Equipo D',
          'fecha': '2024-05-16 16:00',
          'estado': 'Finalizado',
          'resultado': '3 - 1',
        },
        {
          'id': '5',
          'equipoLocal': 'Equipo A',
          'equipoVisitante': 'Equipo D',
          'fecha': '2024-05-17 14:00',
          'estado': 'Finalizado',
          'resultado': '3 - 0',
        },
        {
          'id': '6',
          'equipoLocal': 'Equipo B',
          'equipoVisitante': 'Equipo C',
          'fecha': '2024-05-17 16:00',
          'estado': 'Finalizado',
          'resultado': '1 - 0',
        },
      ],
      'Grupo B': [
        {
          'id': '7',
          'equipoLocal': 'Equipo E',
          'equipoVisitante': 'Equipo F',
          'fecha': '2024-05-15 14:00',
          'estado': 'Finalizado',
          'resultado': '3 - 1',
        },
        {
          'id': '8',
          'equipoLocal': 'Equipo G',
          'equipoVisitante': 'Equipo H',
          'fecha': '2024-05-15 16:00',
          'estado': 'Finalizado',
          'resultado': '2 - 1',
        },
        {
          'id': '9',
          'equipoLocal': 'Equipo E',
          'equipoVisitante': 'Equipo G',
          'fecha': '2024-05-16 14:00',
          'estado': 'Finalizado',
          'resultado': '2 - 0',
        },
        {
          'id': '10',
          'equipoLocal': 'Equipo F',
          'equipoVisitante': 'Equipo H',
          'fecha': '2024-05-16 16:00',
          'estado': 'Finalizado',
          'resultado': '2 - 2',
        },
        {
          'id': '11',
          'equipoLocal': 'Equipo E',
          'equipoVisitante': 'Equipo H',
          'fecha': '2024-05-17 14:00',
          'estado': 'Finalizado',
          'resultado': '3 - 0',
        },
        {
          'id': '12',
          'equipoLocal': 'Equipo F',
          'equipoVisitante': 'Equipo G',
          'fecha': '2024-05-17 16:00',
          'estado': 'Finalizado',
          'resultado': '2 - 1',
        },
      ],
      'Grupo C': [
        {
          'id': '13',
          'equipoLocal': 'Equipo I',
          'equipoVisitante': 'Equipo J',
          'fecha': '2024-05-15 14:00',
          'estado': 'Finalizado',
          'resultado': '2 - 1',
        },
        {
          'id': '14',
          'equipoLocal': 'Equipo K',
          'equipoVisitante': 'Equipo L',
          'fecha': '2024-05-15 16:00',
          'estado': 'Finalizado',
          'resultado': '1 - 1',
        },
        {
          'id': '15',
          'equipoLocal': 'Equipo I',
          'equipoVisitante': 'Equipo K',
          'fecha': '2024-05-16 14:00',
          'estado': 'Finalizado',
          'resultado': '2 - 1',
        },
        {
          'id': '16',
          'equipoLocal': 'Equipo J',
          'equipoVisitante': 'Equipo L',
          'fecha': '2024-05-16 16:00',
          'estado': 'Finalizado',
          'resultado': '3 - 0',
        },
        {
          'id': '17',
          'equipoLocal': 'Equipo I',
          'equipoVisitante': 'Equipo L',
          'fecha': '2024-05-17 14:00',
          'estado': 'Finalizado',
          'resultado': '2 - 0',
        },
        {
          'id': '18',
          'equipoLocal': 'Equipo J',
          'equipoVisitante': 'Equipo K',
          'fecha': '2024-05-17 16:00',
          'estado': 'Finalizado',
          'resultado': '2 - 1',
        },
      ],
      'Grupo D': [
        {
          'id': '19',
          'equipoLocal': 'Equipo M',
          'equipoVisitante': 'Equipo N',
          'fecha': '2024-05-15 14:00',
          'estado': 'Finalizado',
          'resultado': '3 - 0',
        },
        {
          'id': '20',
          'equipoLocal': 'Equipo O',
          'equipoVisitante': 'Equipo P',
          'fecha': '2024-05-15 16:00',
          'estado': 'Finalizado',
          'resultado': '2 - 1',
        },
        {
          'id': '21',
          'equipoLocal': 'Equipo M',
          'equipoVisitante': 'Equipo O',
          'fecha': '2024-05-16 14:00',
          'estado': 'Finalizado',
          'resultado': '3 - 1',
        },
        {
          'id': '22',
          'equipoLocal': 'Equipo N',
          'equipoVisitante': 'Equipo P',
          'fecha': '2024-05-16 16:00',
          'estado': 'Finalizado',
          'resultado': '2 - 2',
        },
        {
          'id': '23',
          'equipoLocal': 'Equipo M',
          'equipoVisitante': 'Equipo P',
          'fecha': '2024-05-17 14:00',
          'estado': 'Finalizado',
          'resultado': '3 - 0',
        },
        {
          'id': '24',
          'equipoLocal': 'Equipo N',
          'equipoVisitante': 'Equipo O',
          'fecha': '2024-05-17 16:00',
          'estado': 'Finalizado',
          'resultado': '2 - 1',
        },
      ],
    };

    // Datos de eliminación directa (estructura original)
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
      for (var fase in enfrentamientosFaseGrupos.keys) {
        final index = enfrentamientosFaseGrupos[fase]!.indexWhere(
          (e) => e['id'] == enfrentamientoActualizado['id'],
        );
        if (index != -1) {
          enfrentamientosFaseGrupos[fase]![index] = enfrentamientoActualizado;
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

  Map<String, List<Map<String, dynamic>>> _generarEnfrentamientosFaseFinal() {
    // Obtener los dos mejores equipos de cada grupo
    final clasificados = _obtenerClasificados();

    // Generar cuartos de final
    // 1A vs 2B, 1B vs 2A, 1C vs 2D, 1D vs 2C
    return {
      'Cuartos de Final': [
        {
          'id': '25',
          'equipoLocal': clasificados['Grupo A']![0]['equipo'],
          'equipoVisitante': clasificados['Grupo B']![1]['equipo'],
          'fecha': '2024-05-20 14:00',
          'estado': 'Programado',
        },
        {
          'id': '26',
          'equipoLocal': clasificados['Grupo B']![0]['equipo'],
          'equipoVisitante': clasificados['Grupo A']![1]['equipo'],
          'fecha': '2024-05-20 16:00',
          'estado': 'Programado',
        },
        {
          'id': '27',
          'equipoLocal': clasificados['Grupo C']![0]['equipo'],
          'equipoVisitante': clasificados['Grupo D']![1]['equipo'],
          'fecha': '2024-05-21 14:00',
          'estado': 'Programado',
        },
        {
          'id': '28',
          'equipoLocal': clasificados['Grupo D']![0]['equipo'],
          'equipoVisitante': clasificados['Grupo C']![1]['equipo'],
          'fecha': '2024-05-21 16:00',
          'estado': 'Programado',
        },
      ],
      'Semifinal': [
        {
          'id': '29',
          'equipoLocal': null,
          'equipoVisitante': null,
          'fecha': '2024-05-25 14:00',
          'estado': 'Pendiente',
        },
        {
          'id': '30',
          'equipoLocal': null,
          'equipoVisitante': null,
          'fecha': '2024-05-25 16:00',
          'estado': 'Pendiente',
        },
      ],
      'Final': [
        {
          'id': '31',
          'equipoLocal': null,
          'equipoVisitante': null,
          'fecha': '2024-05-30 14:00',
          'estado': 'Pendiente',
        },
      ],
    };
  }

  Map<String, List<Map<String, dynamic>>> _obtenerClasificados() {
    Map<String, List<Map<String, dynamic>>> clasificados = {};

    // Para cada grupo, ordenar por puntos y obtener los dos primeros
    for (var grupo in datosGrupos['grupos']) {
      final equiposGrupo = List<Map<String, dynamic>>.from(
        datosGrupos['tablas'][grupo],
      );

      // Ordenar por puntos (y diferencia de goles si hay empate)
      equiposGrupo.sort((a, b) {
        if (a['pts'] != b['pts']) {
          return b['pts'].compareTo(a['pts']);
        }
        // Si hay empate en puntos, usar diferencia de goles
        final difGolesA = a['gf'] - a['gc'];
        final difGolesB = b['gf'] - b['gc'];
        if (difGolesA != difGolesB) {
          return difGolesB.compareTo(difGolesA);
        }
        // Si hay empate en diferencia, usar goles a favor
        return b['gf'].compareTo(a['gf']);
      });

      // Tomar los dos primeros
      clasificados[grupo] = equiposGrupo.take(2).toList();
    }

    return clasificados;
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authNotifierProvider);
    final esAdmin = authAsync.value?.rol == RolUsuario.admin;

    return widget.torneo.metodoEliminacion == MetodoEliminacion.grupos
        ? _buildGruposView(context, esAdmin)
        : widget.torneo.metodoEliminacion == MetodoEliminacion.todosContraTodos
            ? _buildTodosContraTodosView(context, esAdmin)
            : _buildEliminacionDirectaView(context, esAdmin);
  }

  Widget _buildGruposView(BuildContext context, bool esAdmin) {
    // Verificar si la fase de grupos está completa
    bool faseGruposCompleta = _verificarFaseGruposCompleta();

    // Si la fase de grupos está completa, generar enfrentamientos de fase final
    final enfrentamientosFaseFinal =
        faseGruposCompleta ? _generarEnfrentamientosFaseFinal() : null;

    return DefaultTabController(
      length: datosGrupos['grupos'].length,
      child: Scaffold(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
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
                                'Fase de Grupos',
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
                ),
                // Tabs de grupos
                TabBar(
                  isScrollable: true,
                  tabs: datosGrupos['grupos']
                      .map<Widget>((grupo) => Tab(text: grupo))
                      .toList(),
                  onTap: (index) {
                    setState(() {
                      grupoSeleccionado = index;
                    });
                  },
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tabla de posiciones
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tabla de Posiciones',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 12),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        columns: const [
                                          DataColumn(label: Text('Equipo')),
                                          DataColumn(label: Text('PJ')),
                                          DataColumn(label: Text('PG')),
                                          DataColumn(label: Text('PE')),
                                          DataColumn(label: Text('PP')),
                                          DataColumn(label: Text('GF')),
                                          DataColumn(label: Text('GC')),
                                          DataColumn(label: Text('Pts')),
                                        ],
                                        rows: (datosGrupos['tablas'][
                                                    datosGrupos['grupos']
                                                        [grupoSeleccionado]]
                                                as List)
                                            .map<DataRow>((equipo) => DataRow(
                                                  cells: [
                                                    DataCell(
                                                        Text(equipo['equipo'])),
                                                    DataCell(Text(
                                                        '${equipo['pj']}')),
                                                    DataCell(Text(
                                                        '${equipo['pg']}')),
                                                    DataCell(Text(
                                                        '${equipo['pe']}')),
                                                    DataCell(Text(
                                                        '${equipo['pp']}')),
                                                    DataCell(Text(
                                                        '${equipo['gf']}')),
                                                    DataCell(Text(
                                                        '${equipo['gc']}')),
                                                    DataCell(Text(
                                                        '${equipo['pts']}')),
                                                  ],
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Lista de partidos del grupo
                            Text(
                              'Partidos',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            ...enfrentamientosFaseGrupos[datosGrupos['grupos']
                                    [grupoSeleccionado]]!
                                .map((partido) => Card(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: InkWell(
                                        onTap: esAdmin &&
                                                (partido['estado'] ==
                                                        'Programado' ||
                                                    partido['estado'] ==
                                                        'En Progreso')
                                            ? () =>
                                                _mostrarDialogoEditarResultado(
                                                  context,
                                                  partido,
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
                                                      partido['equipoLocal'] ??
                                                          'Por definir',
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            partido['equipoLocal'] ==
                                                                    null
                                                                ? Colors.grey
                                                                : null,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
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
                                                        if (partido.containsKey(
                                                            'resultado'))
                                                          Text(
                                                            partido[
                                                                'resultado']!,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      partido['equipoVisitante'] ??
                                                          'Por definir',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            partido['equipoVisitante'] ==
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    partido['fecha']!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: _getColorEstado(
                                                          partido['estado']!),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Text(
                                                      partido['estado']!,
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
                                                  (partido['estado'] ==
                                                          'Programado' ||
                                                      partido['estado'] ==
                                                          'En Progreso'))
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: Text(
                                                    'Toca para editar resultado',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                      ),
                      // Mostrar fase final si la fase de grupos está completa
                      if (faseGruposCompleta) ...[
                        const Divider(height: 32),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.emoji_events,
                                      size: 24,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Fase Final',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            'Equipos clasificados de cada grupo',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Lista de enfrentamientos por fase
                              ...enfrentamientosFaseFinal!.entries.map((fase) {
                                final partidosFase = fase.value;
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
                                        fase.key,
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
                                    ...partidosFase.map((partido) => Card(
                                          margin:
                                              const EdgeInsets.only(bottom: 12),
                                          child: InkWell(
                                            onTap: esAdmin &&
                                                    (partido['estado'] ==
                                                            'Programado' ||
                                                        partido['estado'] ==
                                                            'En Progreso')
                                                ? () =>
                                                    _mostrarDialogoEditarResultado(
                                                      context,
                                                      partido,
                                                    )
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          partido['equipoLocal'] ??
                                                              'Por definir',
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                partido['equipoLocal'] ==
                                                                        null
                                                                    ? Colors
                                                                        .grey
                                                                    : null,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 16),
                                                        child: Column(
                                                          children: [
                                                            const Text(
                                                              'VS',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                            if (partido
                                                                .containsKey(
                                                                    'resultado'))
                                                              Text(
                                                                partido[
                                                                    'resultado']!,
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          partido['equipoVisitante'] ??
                                                              'Por definir',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                partido['equipoVisitante'] ==
                                                                        null
                                                                    ? Colors
                                                                        .grey
                                                                    : null,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        partido['fecha']!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _getColorEstado(
                                                              partido[
                                                                  'estado']!),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        child: Text(
                                                          partido['estado']!,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimary,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  if (esAdmin &&
                                                      (partido['estado'] ==
                                                              'Programado' ||
                                                          partido['estado'] ==
                                                              'En Progreso'))
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      child: Text(
                                                        'Toca para editar resultado',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          fontStyle:
                                                              FontStyle.italic,
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
                              }).toList(),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _verificarFaseGruposCompleta() {
    // Verificar si todos los partidos de todos los grupos están finalizados
    for (var grupo in enfrentamientosFaseGrupos.values) {
      for (var partido in grupo) {
        if (partido['estado'] != 'Finalizado') {
          return false;
        }
      }
    }
    return true;
  }

  Widget _buildEliminacionDirectaView(BuildContext context, bool esAdmin) {
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
                              'Eliminación Directa',
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
                          ...partidosFase.map((partido) => Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: InkWell(
                                  onTap: esAdmin &&
                                          (partido['estado'] == 'Programado' ||
                                              partido['estado'] ==
                                                  'En Progreso')
                                      ? () => _mostrarDialogoEditarResultado(
                                            context,
                                            partido,
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
                                                partido['equipoLocal'] ??
                                                    'Por definir',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      partido['equipoLocal'] ==
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
                                                  if (partido
                                                      .containsKey('resultado'))
                                                    Text(
                                                      partido['resultado']!,
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
                                                partido['equipoVisitante'] ??
                                                    'Por definir',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      partido['equipoVisitante'] ==
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
                                              partido['fecha']!,
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
                                                    partido['estado']!),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                partido['estado']!,
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
                                            (partido['estado'] ==
                                                    'Programado' ||
                                                partido['estado'] ==
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

  Widget _buildTodosContraTodosView(BuildContext context, bool esAdmin) {
    // TODO: Implementar vista de todos contra todos
    return Scaffold(
      appBar: AppBar(
        title: Text('Enfrentamientos - ${widget.torneo.nombre}'),
      ),
      body: const Center(
        child: Text('Vista de Todos contra Todos en desarrollo'),
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

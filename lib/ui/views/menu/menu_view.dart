import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MenuView extends ConsumerWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton.icon(
            onPressed: () {
              // TODO: Implementar inscripciones
              _showNotImplementedDialog(context);
            },
            label: const Text("Inscripciones"),
            icon: const Icon(Icons.how_to_reg),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              // TODO: Implementar equipos
              _showNotImplementedDialog(context);
            },
            label: const Text("Equipos"),
            icon: const Icon(Icons.groups_2),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              // TODO: Implementar cuadros
              _showNotImplementedDialog(context);
            },
            label: const Text("Cuadros"),
            icon: const Icon(Icons.leaderboard),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              // TODO: Implementar programación
              _showNotImplementedDialog(context);
            },
            label: const Text("Programacion"),
            icon: const Icon(Icons.event),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              context.push("/reglamento");
            },
            label: const Text("Reglamento"),
            icon: const Icon(Icons.gavel),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              context.push("/resoluciones");
            },
            label: const Text("Resoluciones"),
            icon: const Icon(Icons.description),
          ),
        ],
      ),
    );
  }

  void _showNotImplementedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Función no implementada"),
        content: const Text("Esta función aún no está disponible."),
        actions: [
          FilledButton(
            child: const Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

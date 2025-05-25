import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton.icon(
            onPressed: () {},
            label: const Text("Inscripciones"),
            icon: const Icon(Icons.how_to_reg),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {},
            label: const Text("Equipos"),
            icon: const Icon(Icons.groups_2),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {},
            label: const Text("Cuadros"),
            icon: const Icon(Icons.leaderboard),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {},
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
}

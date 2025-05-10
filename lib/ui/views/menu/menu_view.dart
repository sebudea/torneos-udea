import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Torneos UdeA"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text("Equipos"),
              icon: const Icon(Icons.groups_2),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text("Cuadros"),
              icon: const Icon(Icons.leaderboard),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text("Programacion"),
              icon: const Icon(Icons.event),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text("Reglamento"),
              icon: const Icon(Icons.gavel),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text("Resoluciones"),
              icon: const Icon(Icons.description),
            ),
          ],
        ),
      ),
    );
  }
}

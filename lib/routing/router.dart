import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:torneos_udea/ui/views/menu/menu_view.dart';
import 'package:torneos_udea/ui/views/reglamento/reglamento_view.dart';
import 'package:torneos_udea/ui/views/resoluciones/resoluciones_view.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: "/",
    routes: [
      ShellRoute(
        routes: [
          // Ruta principal
          GoRoute(
            path: "/",
            builder: (context, state) => const MenuView(),
          ),
          GoRoute(
            path: "/reglamento",
            builder: (context, state) => const ReglamentoView(),
          ),
          GoRoute(
            path: "/resoluciones",
            builder: (context, state) => const ResolucionesView(),
          ),
        ],
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text("Torneos UdeA"),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Iniciar sesión"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                                "Inicia sesión con tu cuenta de Google para continuar."),
                            const SizedBox(height: 16),
                            FilledButton.icon(
                              icon: const Icon(Icons.login),
                              label: const Text("Continuar con Google"),
                              onPressed: () {
                                // Aquí deberías integrar tu lógica de login con Google
                                Navigator.of(context).pop();
                                // Por ejemplo: context.read<AuthProvider>().signInWithGoogle();
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: const Text("Cancelar"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
              leading: state.fullPath != "/"
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => GoRouter.of(context).pop(),
                    )
                  : null,
            ),
            body: child,
          );
        },
      ),
    ],
  );
}

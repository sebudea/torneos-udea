import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:torneos_udea/services/auth_service.dart';
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
                Builder(
                  builder: (context) {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      // Usuario autenticado: muestra avatar y menú de logout
                      return PopupMenuButton(
                        icon: user.photoURL != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(user.photoURL!),
                              )
                            : const Icon(Icons.account_circle),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text('Cerrar sesión'),
                            onTap: () {
                              // Mostrar un AlertDialog de confirmación antes de cerrar sesión
                              Future.delayed(Duration.zero, () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('¿Cerrar sesión?'),
                                    content: const Text(
                                        '¿Estás seguro de que deseas cerrar sesión?'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancelar'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                      TextButton(
                                        child: const Text('Cerrar sesión'),
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          await FirebaseAuth.instance.signOut();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Sesión cerrada')),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                          ),
                        ],
                      );
                    } else {
                      // No autenticado: muestra icono de login
                      return IconButton(
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
                                    onPressed: () async {
                                      final userCredential =
                                          await AuthService.signInWithGoogle();
                                      Navigator.of(context).pop();
                                      if (userCredential == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'No se pudo iniciar sesión con Google'),
                                          ),
                                        );
                                      }
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
                      );
                    }
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

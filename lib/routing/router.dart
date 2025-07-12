import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:torneos_udea/domain/models/torneo_model.dart';
import 'package:torneos_udea/ui/providers/auth_provider.dart';
import 'package:torneos_udea/ui/views/auth/auth_view.dart';
import 'package:torneos_udea/ui/views/enfrentamientos/enfrentamientos_view.dart';
import 'package:torneos_udea/ui/views/equipos/equipos_view.dart';
import 'package:torneos_udea/ui/views/menu/menu_view.dart';
import 'package:torneos_udea/ui/views/reglamento/reglamento_view.dart';
import 'package:torneos_udea/ui/views/resoluciones/resoluciones_view.dart';
import 'package:torneos_udea/ui/views/torneos/torneos_view.dart';
import 'package:torneos_udea/ui/widgets/error_widget.dart';
import 'package:torneos_udea/ui/widgets/loading_widget.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: "/",
    redirect: (context, state) {
      // Lista de rutas que requieren autenticación
      final protectedRoutes = ['/torneos', '/equipos'];

      // Si la ruta actual requiere autenticación
      if (protectedRoutes.contains(state.matchedLocation)) {
        final isAuthenticated = FirebaseAuth.instance.currentUser != null;

        // Si no está autenticado, redirigir a auth con la ruta original
        if (!isAuthenticated) {
          return '/auth?from=${state.matchedLocation}';
        }
      }

      return null; // No redirigir
    },
    routes: [
      ShellRoute(
        routes: [
          // Ruta principal
          GoRoute(
            path: "/",
            builder: (context, state) => const MenuView(),
          ),
          // Ruta de autenticación
          GoRoute(
            path: "/auth",
            builder: (context, state) => AuthView(
              from: state.uri.queryParameters['from'] ?? '/',
            ),
          ),
          GoRoute(
            path: "/torneos",
            builder: (context, state) => const TorneosView(),
          ),
          GoRoute(
            path: "/equipos",
            builder: (context, state) => const EquiposView(),
          ),
          GoRoute(
            path: "/reglamento",
            builder: (context, state) => const ReglamentoView(),
          ),
          GoRoute(
            path: "/resoluciones",
            builder: (context, state) => const ResolucionesView(),
          ),
          // Nueva ruta para enfrentamientos
          GoRoute(
            path: "/enfrentamientos",
            builder: (context, state) {
              final torneo = state.extra as TorneoModel;
              return EnfrentamientosView(torneo: torneo);
            },
          ),
        ],
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 0,
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.sports_soccer,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Torneos UdeA",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              centerTitle: false,
              actions: [
                Consumer(
                  builder: (context, ref, child) {
                    final authAsync = ref.watch(authNotifierProvider);

                    return authAsync.when(
                      data: (usuario) {
                        if (usuario != null) {
                          // Obtener el usuario de Firebase para el photoURL
                          final firebaseUser =
                              FirebaseAuth.instance.currentUser;

                          // Usuario autenticado: muestra avatar y menú de logout
                          return PopupMenuButton(
                            icon: firebaseUser?.photoURL != null
                                ? CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(firebaseUser!.photoURL!),
                                    radius: 16,
                                  )
                                : const Icon(Icons.account_circle),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text(
                                  usuario.rol.name.toLowerCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                enabled: false,
                              ),
                              PopupMenuItem(
                                child: const Text('Cerrar sesión'),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Cerrar sesión'),
                                      content: const Text(
                                          '¿Estás seguro de que quieres cerrar sesión?'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Cancelar'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                        FilledButton(
                                          child: const Text('Cerrar sesión'),
                                          onPressed: () {
                                            ref
                                                .read(authNotifierProvider
                                                    .notifier)
                                                .signOut();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          // No autenticado: muestra icono de login
                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: FilledButton.icon(
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
                                          label: const Text(
                                              "Continuar con Google"),
                                          onPressed: () async {
                                            await ref
                                                .read(authNotifierProvider
                                                    .notifier)
                                                .signInWithGoogle();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      OutlinedButton(
                                        child: const Text("Cancelar"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.login, size: 18),
                              label: const Text("Iniciar sesión"),
                            ),
                          );
                        }
                      },
                      loading: () => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      error: (error, stackTrace) => IconButton(
                        icon: const Icon(Icons.error),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Error de autenticación"),
                              content: ErrorDisplayWidget(
                                error: error,
                                stackTrace: stackTrace,
                              ),
                              actions: [
                                FilledButton(
                                  child: const Text("OK"),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          );
                        },
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

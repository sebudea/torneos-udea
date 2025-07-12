import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:torneos_udea/ui/providers/auth_provider.dart';
import 'package:torneos_udea/ui/widgets/udea_logo.dart';

class AuthView extends ConsumerWidget {
  final String from;

  const AuthView({
    super.key,
    required this.from,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observar el estado de autenticación
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenData((usuario) {
        if (usuario != null) {
          // Siempre redirigir al menú principal después de iniciar sesión
          context.go('/');
        }
      });
    });

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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const UdeALogo(size: 120),
                  const SizedBox(height: 40),
                  Text(
                    'Acceso Requerido',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Para acceder a esta sección, necesitas iniciar sesión con tu cuenta institucional.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.color
                              ?.withOpacity(0.7),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  FilledButton.icon(
                    onPressed: () {
                      ref
                          .read(authNotifierProvider.notifier)
                          .signInWithGoogle();
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Continuar con Google'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Volver al Menú'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

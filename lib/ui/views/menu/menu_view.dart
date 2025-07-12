import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:torneos_udea/domain/models/usuario_model.dart';
import 'package:torneos_udea/ui/providers/auth_provider.dart';
import 'package:torneos_udea/ui/widgets/udea_logo.dart';

class MenuView extends ConsumerWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(authNotifierProvider).value;

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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header con logo
                _buildHeader(context),
                const SizedBox(height: 32),
                // Botón temporal para cambiar rol (solo para desarrollo)
                if (usuario != null) _buildRoleSwitcher(context, ref, usuario),
                // Grid de opciones
                Expanded(
                  child: _buildMenuGrid(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSwitcher(
      BuildContext context, WidgetRef ref, UsuarioModel usuario) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange),
      ),
      child: Row(
        children: [
          Icon(
            Icons.admin_panel_settings,
            color: Colors.orange,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Rol actual: ${usuario.rol.name.toUpperCase()}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          FilledButton(
            onPressed: () {
              final newRole = usuario.rol == RolUsuario.admin
                  ? RolUsuario.user
                  : RolUsuario.admin;
              ref.read(authNotifierProvider.notifier).updateUserRole(newRole);
            },
            child: Text(
                'Cambiar a ${usuario.rol == RolUsuario.admin ? 'USER' : 'ADMIN'}'),
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
      child: Column(
        children: [
          Row(
            children: [
              const UdeALogo(size: 48, showText: false),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Torneos UdeA',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                    ),
                    Text(
                      'Olimpiadas Deportivas',
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
        ],
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _buildMenuCard(
          context,
          title: 'Torneos',
          icon: Icons.emoji_events,
          color: Colors.blue,
          onTap: () => context.push("/torneos"),
        ),
        _buildMenuCard(
          context,
          title: 'Equipos',
          icon: Icons.groups_2,
          color: Colors.green,
          onTap: () => context.push("/equipos"),
        ),
        _buildMenuCard(
          context,
          title: 'Reglamento',
          icon: Icons.gavel,
          color: Colors.red,
          onTap: () => context.push("/reglamento"),
        ),
        _buildMenuCard(
          context,
          title: 'Resoluciones',
          icon: Icons.description,
          color: Colors.teal,
          onTap: () => context.push("/resoluciones"),
        ),
      ],
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
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

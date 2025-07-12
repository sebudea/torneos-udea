import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:torneos_udea/domain/models/usuario_model.dart';
import 'package:torneos_udea/services/auth_service.dart';
import 'package:torneos_udea/services/user_service.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<UsuarioModel?> build() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    // Obtener usuario desde Firestore
    final usuario = await UserService.getUserById(user.uid);
    return usuario;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();

    try {
      final userCredential = await AuthService.signInWithGoogle();
      if (userCredential?.user != null) {
        final user = userCredential!.user!;

        // Crear o actualizar usuario en Firestore
        await UserService.createOrUpdateUser(user);

        // Obtener usuario actualizado desde Firestore
        final usuario = await UserService.getUserById(user.uid);
        state = AsyncValue.data(usuario);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();

    try {
      await FirebaseAuth.instance.signOut();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Método para actualizar rol de usuario (solo para desarrollo)
  Future<void> updateUserRole(RolUsuario rol) async {
    final currentUser = state.value;
    if (currentUser == null) return;

    try {
      await UserService.updateUserRole(currentUser.id, rol);

      // Actualizar el estado con el nuevo rol
      final updatedUser = UsuarioModel(
        id: currentUser.id,
        nombre: currentUser.nombre,
        email: currentUser.email,
        rol: rol,
        activo: currentUser.activo,
        createdAt: currentUser.createdAt,
        updatedAt: DateTime.now(),
      );

      state = AsyncValue.data(updatedUser);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

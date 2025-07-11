import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:torneos_udea/domain/models/user_model.dart';
import 'package:torneos_udea/services/auth_service.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<UserModel?> build() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoURL: user.photoURL,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();

    try {
      final userCredential = await AuthService.signInWithGoogle();
      if (userCredential?.user != null) {
        final user = userCredential!.user!;
        final userModel = UserModel(
          id: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? '',
          photoURL: user.photoURL,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        state = AsyncValue.data(userModel);
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
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      // Inicia el flujo de autenticación de Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // El usuario canceló

      // Obtiene los detalles de autenticación de Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Crea una nueva credencial para Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Inicia sesión en Firebase con la credencial de Google
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Puedes manejar el error aquí o mostrar un mensaje
      return null;
    }
  }
}

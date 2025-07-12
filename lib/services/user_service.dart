import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:torneos_udea/domain/models/usuario_model.dart';

class UserService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'usuarios';

  // Crear o actualizar usuario en Firestore
  static Future<void> createOrUpdateUser(User firebaseUser) async {
    final userDoc = _firestore.collection(_collection).doc(firebaseUser.uid);

    final userData = {
      'id': firebaseUser.uid,
      'nombre': firebaseUser.displayName ?? '',
      'email': firebaseUser.email ?? '',
      'rol': 'user', // Por defecto es user
      'activo': true,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    await userDoc.set(userData, SetOptions(merge: true));
  }

  // Obtener usuario por ID
  static Future<UsuarioModel?> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();

      if (doc.exists) {
        final data = doc.data()!;
        return UsuarioModel(
          id: data['id'] ?? '',
          nombre: data['nombre'] ?? '',
          email: data['email'] ?? '',
          rol: _parseRol(data['rol'] ?? 'user'),
          activo: data['activo'] ?? true,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          updatedAt: (data['updatedAt'] as Timestamp).toDate(),
        );
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Actualizar rol de usuario
  static Future<void> updateUserRole(String userId, RolUsuario rol) async {
    await _firestore.collection(_collection).doc(userId).update({
      'rol': rol.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Verificar si usuario es admin
  static Future<bool> isUserAdmin(String userId) async {
    final user = await getUserById(userId);
    return user?.rol == RolUsuario.admin;
  }

  // Convertir string a RolUsuario
  static RolUsuario _parseRol(String rol) {
    switch (rol.toLowerCase()) {
      case 'admin':
        return RolUsuario.admin;
      case 'user':
      default:
        return RolUsuario.user;
    }
  }
}

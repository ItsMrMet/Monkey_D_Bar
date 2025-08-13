// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _fakeEmail(String username) {
    return '$username@fake.com';
  }

  // Crear usuario
  Future<String?> createUser({
    required String username,
    required String pin,
    required String faction,
  }) async {
    try {
      final email = _fakeEmail(username);

      // Crear usuario en Firebase Auth
      await _auth.createUserWithEmailAndPassword(email: email, password: pin);

      // Guardar la facción en Firestore
      await _firestore.collection('users').doc(username).set({
        'faction': faction,
      });

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'El usuario ya existe';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Login
  Future<String?> loginUser({
    required String username,
    required String pin,
  }) async {
    try {
      final email = _fakeEmail(username);
      await _auth.signInWithEmailAndPassword(email: email, password: pin);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return 'Usuario o PIN incorrecto';
      }
      return e.message;
    }
  }

  // Obtener facción
  Future<String?> getFaction(String username) async {
    final doc = await _firestore.collection('users').doc(username).get();
    if (!doc.exists) return null;
    return doc.data()?['faction'];
  }

  // Reset PIN (admin)
  Future<String?> resetPin(String username, String newPin) async {
    try {
      final user = await _auth.fetchSignInMethodsForEmail(_fakeEmail(username));
      if (user.isEmpty) return 'Usuario no encontrado';

      // Firebase Admin normalmente sería necesario para cambiar contraseñas sin login,
      // pero en Flutter, desde el cliente puedes usar sendPasswordResetEmail
      await _auth.sendPasswordResetEmail(email: _fakeEmail(username));

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}

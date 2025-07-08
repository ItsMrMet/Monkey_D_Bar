// lib/services/auth_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

Future<String?> createUser({
  required String username,
  required String password,
  required String faction,
}) async {
  final usersRef = FirebaseFirestore.instance.collection('users');

  final userSnapshot = await usersRef.doc(username).get();

  if (userSnapshot.exists) {
    return 'El usuario ya existe';
  }

  await usersRef.doc(username).set({
    'password': password,
    'faction': faction,
  });

  return null;
}

Future<String?> loginUser({
  required String username,
  required String password,
}) async {
  final userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(username).get();

  if (!userSnapshot.exists) return 'Usuario no encontrado';

  final data = userSnapshot.data();
  if (data?['password'] != password) return 'Contraseña incorrecta';

  return null; // login correcto
}

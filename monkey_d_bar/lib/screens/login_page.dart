import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'card_page.dart';

class LoginPage extends StatefulWidget {
  final void Function(String faction) onLoginSuccess;
  const LoginPage({super.key, required this.onLoginSuccess});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginUser() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.length != 4) {
      _showSnackbar('Completa todos los campos.');
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(username)
          .get();

      if (!doc.exists || doc['password'] != password) {
        _showSnackbar('Credenciales inválidas.');
        return;
      }

      final faction = doc['faction'];

      // 👉 Cambia el tema antes de navegar
      widget.onLoginSuccess(faction);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CardPage(username: username, faction: faction),
        ),
      );
    } catch (e) {
      _showSnackbar('Ocurrió un error. Intenta de nuevo.');
    }
  }

  void _showSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              maxLength: 4,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Contraseña (4 dígitos)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                counterText: '',
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loginUser,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Entrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

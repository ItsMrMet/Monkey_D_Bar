import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'card_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _pinController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    final username = _usernameController.text.trim();
    final pin = _pinController.text.trim();

    if (username.isEmpty || pin.isEmpty) {
      _showSnackbar('Completa todos los campos.');
      return;
    }

    if (pin.length != 6) {
      _showSnackbar('El PIN debe tener 6 dígitos.');
      return;
    }

    final error = await _authService.loginUser(username: username, pin: pin);

    if (error != null) {
      _showSnackbar(error);
      return;
    }

    final faction = await _authService.getFaction(username);
    if (faction == null) {
      _showSnackbar('Error al obtener la facción');
      return;
    }

    _showSnackbar('Login exitoso');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CardPage(username: username, faction: faction),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _pinController,
              decoration: const InputDecoration(labelText: 'PIN (6 dígitos)'),
              obscureText: true,
              maxLength: 6,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}

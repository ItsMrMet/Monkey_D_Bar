import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'card_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _pinController = TextEditingController();
  String? _selectedFaction;

  final AuthService _authService = AuthService();

  // Mapa de facciones para mostrar emojis en UI pero guardar clave limpia
  final Map<String, String> factions = {
    'pirata': '🏴‍☠️ Pirata',
    'marine': '⚓ Marine',
  };

  void _register() async {
    final username = _usernameController.text.trim();
    final pin = _pinController.text.trim();

    if (username.isEmpty || pin.isEmpty || _selectedFaction == null) {
      _showSnackbar('Completa todos los campos.');
      return;
    }

    if (pin.length != 6) {
      _showSnackbar('El PIN debe tener 6 dígitos.');
      return;
    }

    final error = await _authService.createUser(
      username: username,
      pin: pin,
      faction: _selectedFaction!,
    );

    if (error != null) {
      _showSnackbar(error);
      return;
    }

    _showSnackbar('Usuario registrado exitosamente');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            CardPage(username: username, faction: _selectedFaction!),
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
      appBar: AppBar(title: const Text('Crear Usuario')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _pinController,
              decoration: const InputDecoration(
                labelText: 'PIN (6 dígitos)',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              maxLength: 6,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Facción',
                border: OutlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedFaction,
                  hint: const Text('Selecciona una facción'),
                  items: factions.entries
                      .map((entry) => DropdownMenuItem(
                            value: entry.key, // pirata / marine
                            child: Text(entry.value), // 🏴‍☠️ Pirata / ⚓ Marine
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedFaction = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _register,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Crear Cuenta'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

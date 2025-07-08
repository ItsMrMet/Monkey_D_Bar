import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  final String username;
  final String faction;

  const CardPage({super.key, required this.username, required this.faction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tu carta')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido, $username', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text(
              faction == 'pirata'
                  ? '🏴‍☠️ Facción: Pirata'
                  : '⚓ Facción: Marine',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

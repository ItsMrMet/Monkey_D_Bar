import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // este lo genera flutterfire configure

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monkey D. Bar',
      home: Scaffold(
        appBar: AppBar(title: Text('Bienvenido')),
        body: Center(child: Text('¡Hola Firebase!')),
      ),
    );
  }
}

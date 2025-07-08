import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Importa tu archivo

import 'package:monkey_d_bar/theme.dart';
import 'screens/welcome_page.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AppRoot());
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  ThemeData _currentTheme = neutralTheme;

  void switchTheme(String faction) {
    setState(() {
      if (faction == 'pirata') {
        _currentTheme = pirateTheme;
      } else if (faction == 'marine') {
        _currentTheme = marineTheme;
      } else {
        _currentTheme = neutralTheme;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monkey D. Bar',
      debugShowCheckedModeBanner: false,
      theme: _currentTheme,
      home: WelcomePage(onLoginSuccess: switchTheme),
      routes: {
        '/login': (_) => LoginPage(onLoginSuccess: switchTheme),
        '/register': (_) => const RegisterPage(),
      },
    );
  }
}

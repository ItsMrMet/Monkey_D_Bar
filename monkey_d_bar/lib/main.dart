import 'package:flutter/material.dart';
import 'package:monkey_d_bar/theme.dart';
import 'screens/welcome_page.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  // Inicialmente usamos el tema neutro
  ThemeData _currentTheme = neutralTheme;

  // Cambiaremos el tema tras login en función de la facción
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

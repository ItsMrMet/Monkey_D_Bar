import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Importa tu archivo

import 'package:monkey_d_bar/theme.dart';
import 'screens/welcome_page.dart';

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
      home: WelcomePageWrapper(
        onThemeChange: switchTheme,
      ),
    );
  }
}

class WelcomePageWrapper extends StatelessWidget {
  final void Function(String faction) onThemeChange;
  const WelcomePageWrapper({super.key, required this.onThemeChange});

  @override
  Widget build(BuildContext context) {
    return WelcomePageWrapperInner(onThemeChange: onThemeChange);
  }
}

// Esto permite pasar el callback de tema a login/register y a CardPage
class WelcomePageWrapperInner extends StatelessWidget {
  final void Function(String faction) onThemeChange;
  const WelcomePageWrapperInner({super.key, required this.onThemeChange});

  @override
  Widget build(BuildContext context) {
    return WelcomePageCustom(
      onThemeChange: onThemeChange,
    );
  }
}

class WelcomePageCustom extends StatelessWidget {
  final void Function(String faction) onThemeChange;
  const WelcomePageCustom({super.key, required this.onThemeChange});

  @override
  Widget build(BuildContext context) {
    return WelcomePage(
        // Ahora WelcomePage ya no recibe onLoginSuccess, solo navegamos directo
        );
  }
}

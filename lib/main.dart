import 'package:flutter/material.dart';
import 'package:rdv/screens/LoginScreen.dart';
// Assurez-vous d'importer le fichier carrousel.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Écran de Connexion',
      theme: ThemeData(
        primaryColor: const Color(0xFFE73162),
      ),
      home: const LoginScreen(),
    );
  }
}

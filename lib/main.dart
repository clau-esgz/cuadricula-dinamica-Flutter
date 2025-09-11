import 'package:flutter/material.dart';
// import 'login.dart'; // Apunte de clase, no borrar
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // home: const Login(), // Apunte de clase, no borrar
      home: const Home(), // Visualiza la cuadrícula de home.dart
    );
  }
}
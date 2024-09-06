import 'package:flutter/material.dart';
import 'package:flutter_application_5/services/auth_service.dart'; // Ajusta el import según tu estructura
import 'pages/login_page.dart';
import 'pages/user_management_page.dart'; // Importa tu página de gestión de usuarios

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthService authService = AuthService();
  await authService.saveCredentials(); // Guarda credenciales de prueba
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Cheftable',
      home: LoginPage(),
    );
  }
}


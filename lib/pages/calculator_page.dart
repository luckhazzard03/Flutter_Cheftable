import 'package:flutter/material.dart';
import 'user_management_page.dart'; // Importa la página de gestión de usuarios

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Usuarios Cheftable',
      home: UserManagementPage(), // Reemplaza la página de inicio
    );
  }
}

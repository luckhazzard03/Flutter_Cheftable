import 'package:flutter/material.dart';
import 'package:flutter_application_5/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/login_page.dart';
import 'pages/user_management_page.dart'; // Asegúrate de tener esta página

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Instanciar el AuthService
  final AuthService authService = AuthService();

  // Verificar si el usuario ya está autenticado
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cheftable',
      home: isLoggedIn ? const UserManagementPage() : const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/user_management': (context) => const UserManagementPage(),
      },
    );
  }
}

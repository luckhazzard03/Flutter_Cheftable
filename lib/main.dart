import 'package:flutter/material.dart';
import 'package:flutter_application_5/services/auth_service.dart'; // Ajusta el import según tu estructura
// Importa tu página de gestión de usuarios
import 'pages/login_page.dart';

// Asegúrate de importar tu AuthService// Importa tu página de gestión de usuarios

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
      title: 'Cheftable',
      home:
          LoginPage(), // Cambia esta línea para la página que desees como inicio
    );
  }
}

//SE AJUSTA PARA LA CONEXIÓN DEL API 

// import 'package:flutter/material.dart';
// import 'package:flutter_application_5/services/auth_service.dart';
// import 'pages/login_page.dart';
// import 'pages/user_management_page.dart'; // Asegúrate de tener esta página
// import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
  
//   final AuthService authService = AuthService();
  
//   // Verificar si el usuario ya está autenticado
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

//   runApp(MyApp(isLoggedIn: isLoggedIn));
// }

// class MyApp extends StatelessWidget {
//   final bool isLoggedIn;

//   const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Cheftable',
//       home: isLoggedIn ? const UserManagementPage() : const LoginPage(),
//       routes: {
//         '/login': (context) => const LoginPage(),
//         '/user_management': (context) => const UserManagementPage(),
//       },
//     );
//   }
// }

// Cambios principales:
// Verificación de autenticación: Ahora verificamos si el usuario ya está autenticado usando SharedPreferences.
// Página inicial dinámica: Dependiendo de si el usuario está autenticado o no, la aplicación iniciará en UserManagementPage o LoginPage.
// Rutas definidas: Se han agregado rutas para facilitar la navegación entre páginas.
// Eliminación de saveCredentials(): Ya no guardamos credenciales de prueba al inicio de la aplicación. En su lugar, confiamos en el proceso de inicio de sesión real.
// Paso del estado de autenticación: Pasamos el estado de autenticación al constructor de MyApp.
// Estos cambios aseguran que:
// La aplicación verifique el estado de autenticación al inicio.
// Los usuarios autenticados sean dirigidos directamente a la página principal.
// Los usuarios no autenticados vean la página de inicio de sesión.
// La navegación entre páginas sea más fácil y estructurada.
// Recuerda asegurarte de que:
// Tengas una UserManagementPage implementada.
// Tu LoginPage actualice correctamente el estado de is_logged_in en SharedPreferences después de un inicio de sesión exitoso.
// Implementes un mecanismo de cierre de sesión que actualice is_logged_in a false cuando el usuario cierre sesión.
// Esta estructura proporciona una base sólida para manejar la autenticación y la navegación en tu aplicación Flutter.

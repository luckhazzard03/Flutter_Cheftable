import 'package:flutter/material.dart';
import 'user_management_page.dart'; // Asegúrate de que esta página exista y esté correctamente importada
import '../services/auth_service.dart'; // Ajusta el import según tu estructura
import 'package:shared_preferences/shared_preferences.dart'; // Asegúrate de tener esta dependencia

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserManagementPage()),
      );
    }
  }


//CONEXIÓN PARA EL API EN CODEIGNITER
//en EL LoginPage, modificaR el método _login() para usar este nuevo método: Y APLICARLO EN USER Y ORDER
//   void _login() async {
//   String username = _usernameController.text;
//   String password = _passwordController.text;

//   if (username.isNotEmpty && password.isNotEmpty) {
//     try {
//       final result = await _authService.login(username, password);
      
//       // Guardar estado de autenticación
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('is_logged_in', true);

//       // Puedes guardar más información del usuario si la API la devuelve
//       // Por ejemplo: await prefs.setString('user_id', result['user_id']);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Ingreso exitoso')),
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const UserManagementPage()),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error de inicio de sesión: ${e.toString()}')),
//       );
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Por favor, ingresa usuario y contraseña')),
//     );
//   }
// }

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      bool isValid = await _authService.validateCredentials(username, password);

      if (isValid) {
        // Guardar estado de autenticación
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_logged_in', true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ingreso exitoso'),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserManagementPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuario o contraseña incorrectos'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, ingresa usuario y contraseña'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/rest.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: const Color.fromARGB(206, 179, 255, 0),
                child: ClipOval(
                  child: Image.asset(
                    'assets/img/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuario',
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(206, 179, 255, 0),
                foregroundColor: const Color.fromARGB(255, 34, 57, 87),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 12.0),
              ),
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}

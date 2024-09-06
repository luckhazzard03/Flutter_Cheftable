import 'package:flutter/material.dart';
import 'calculator_page.dart';
import '../services/auth_service.dart'; // Ajusta el import según tu estructura

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      bool isValid = await _authService.validateCredentials(username, password);

      if (isValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ingreso exitoso'),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
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
            image: AssetImage('assets/img/rest.jpg'), // Usa una imagen local
            fit: BoxFit.cover, // Ajusta la imagen para que cubra todo el fondo
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150, // Ajusta el ancho del contenedor
              height: 150, // Ajusta la altura del contenedor
              child: CircleAvatar(
                radius: 100, // Tamaño del avatar
                backgroundColor: const Color.fromARGB(206, 179, 255, 0),
                child: ClipOval(
                  child: Image.asset(
                    'assets/img/logo.png',
                    fit: BoxFit
                        .contain, // Ajusta la imagen para que se ajuste dentro del círculo
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
                fillColor:
                    Colors.white.withOpacity(0.8), // Fondo semitransparente
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Bordes redondeados
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true, // Encripta el texto
              decoration: InputDecoration(
                labelText: 'Contraseña',
                filled: true,
                fillColor:
                    Colors.white.withOpacity(0.8), // Fondo semitransparente
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Bordes redondeados
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 18, 32, 63), // Color de fondo del botón
                foregroundColor: Colors.white, // Color del texto del botón
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Bordes redondeados
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

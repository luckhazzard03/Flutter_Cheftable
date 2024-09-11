import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'user_management_page.dart';
import '../controllers/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginController(AuthService()),
      child: Scaffold(
        body: Consumer<LoginController>(
          builder: (context, loginController, child) {
            return Container(
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
                    controller: loginController.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: loginController.passwordController,
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
                    onPressed: () async {
                      await loginController.login(
                        loginController.emailController.text,
                        loginController.passwordController.text,
                      );
                      if (loginController.user != null) {
                        // Guardar estado de autenticación
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('is_logged_in', true);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserManagementPage()),
                        );
                      } else if (loginController.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(loginController.errorMessage!),
                          ),
                        );
                      }
                    },
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
                  if (loginController.isLoading)
                    const CircularProgressIndicator(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

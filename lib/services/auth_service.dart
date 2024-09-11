import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_5/utils/constans.dart';

class AuthService {
  
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Utilidad para hashear contraseñas
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Método para iniciar sesión con la API
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrlLogin'),//Usa la constante desde constans.dart
      body: jsonEncode({
        'email': email, // Cambiar 'username' a 'email'
        'password': password // Enviar la contraseña en texto plano
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Guardar las credenciales localmente después de un inicio de sesión exitoso
      await _saveCredentials(
          email,
          hashPassword(
              password)); // Puedes almacenar contraseñas hasheadas si es necesario
      return responseData;
    } else {
      throw Exception('Failed to login');
    }
  }

  // Guardar credenciales localmente
  Future<void> _saveCredentials(String email, String hashedPassword) async {
    await _storage.write(
        key: 'username', value: email); // Cambia 'username' a 'email'
    await _storage.write(key: 'password', value: hashedPassword);
  }

  // Validar credenciales localmente (útil para verificaciones rápidas sin necesidad de API)
  Future<bool> validateCredentials(String email, String password) async {
    String? storedEmail =
        await _storage.read(key: 'username'); // Cambia 'username' a 'email'
    String? storedPassword = await _storage.read(key: 'password');
    String hashedPassword = hashPassword(password);

    return email == storedEmail && hashedPassword == storedPassword;
  }

  // Método para cerrar sesión
  Future<void> logout() async {
    await _storage.delete(key: 'username'); // Cambia 'username' a 'email'
    await _storage.delete(key: 'password');
    // Aquí podrías agregar una llamada a la API para invalidar el token si es necesario
  }
}

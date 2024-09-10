import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

// Utilidad para hashear contraseñas
String hashPassword(String password) {
  final bytes = utf8.encode(password); // Convertir a bytes
  final digest = sha256.convert(bytes); // Crear hash con SHA-256
  return digest.toString();
}

class AuthService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Guardar credenciales de prueba
  Future<void> saveCredentials() async {
    String hashedPassword = hashPassword('123456');
    // Guardar el usuario y la contraseña encriptada
    await _storage.write(key: 'username', value: 'lordart03@gmail.com');
    await _storage.write(key: 'password', value: hashedPassword);
  }

  // Validar credenciales
  Future<bool> validateCredentials(String username, String password) async {
    String? storedUsername = await _storage.read(key: 'username');
    String? storedPassword = await _storage.read(key: 'password');
    String hashedPassword = hashPassword(password);

    // Comparar credenciales ingresadas con las almacenadas
    return username == storedUsername && hashedPassword == storedPassword;
  }
}

//SE AJUSTA PARA LA CONEXIÓN DEL API 

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:crypto/crypto.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AuthService {
//   static const String baseUrl = 'https://tudominio.com/api'; // Ajusta esta URL
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();

//   // Utilidad para hashear contraseñas
//   String hashPassword(String password) {
//     final bytes = utf8.encode(password);
//     final digest = sha256.convert(bytes);
//     return digest.toString();
//   }

//   // Método para iniciar sesión con la API
//   Future<Map<String, dynamic>> login(String username, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/login'),
//       body: jsonEncode({
//         'username': username,
//         'password': hashPassword(password) // Enviar la contraseña hasheada
//       }),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);
//       // Guardar las credenciales localmente después de un inicio de sesión exitoso
//       await _saveCredentials(username, hashPassword(password));
//       return responseData;
//     } else {
//       throw Exception('Failed to login');
//     }
//   }

//   // Guardar credenciales localmente
//   Future<void> _saveCredentials(String username, String hashedPassword) async {
//     await _storage.write(key: 'username', value: username);
//     await _storage.write(key: 'password', value: hashedPassword);
//   }

//   // Validar credenciales localmente (útil para verificaciones rápidas sin necesidad de API)
//   Future<bool> validateCredentials(String username, String password) async {
//     String? storedUsername = await _storage.read(key: 'username');
//     String? storedPassword = await _storage.read(key: 'password');
//     String hashedPassword = hashPassword(password);

//     return username == storedUsername && hashedPassword == storedPassword;
//   }

//   // Método para cerrar sesión
//   Future<void> logout() async {
//     await _storage.delete(key: 'username');
//     await _storage.delete(key: 'password');
//     // Aquí podrías agregar una llamada a la API para invalidar el token si es necesario
//   }
// }

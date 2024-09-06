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

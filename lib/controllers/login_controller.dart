import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa aquí
import '../services/auth_service.dart';
import '../models/user.dart';

class LoginController with ChangeNotifier {
  final AuthService authService;

  LoginController(this.authService);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  User? _user;
  User? get user => _user;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    _errorMessage = null; // Clear previous error message

    try {
      final userResponse = await authService.login(email, password);
      _user = User.fromJson(userResponse);
      // Guardar estado de autenticación
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      // Handle successful login, e.g., save the user information or navigate
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

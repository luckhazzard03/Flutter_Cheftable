// models/user.dart

class User {
  final String name;
  final String email;
  final String phone;
  final String role;
  final String password;

  User(
      {required this.name,
      required this.email,
      required this.phone,
      required this.role,
      required this.password});
}

// lib/models/login.dart
class Login {
  final int idUsuario;
  final String nombre;
  final String password;
  final String email;
  final String telefono;
  final int idRolesFk;
  final DateTime createAt;
  final DateTime updateAt;

  Login({
    required this.idUsuario,
    required this.nombre,
    required this.password,
    required this.email,
    required this.telefono,
    required this.idRolesFk,
    required this.createAt,
    required this.updateAt,
  });

  // Factory constructor to create an instance from a JSON map
  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      idUsuario: json['idUsuario'],
      nombre: json['Nombre'],
      password: json['Password'],
      email: json['Email'],
      telefono: json['Telefono'],
      idRolesFk: json['idRoles_fk'],
      createAt: DateTime.parse(json['create_at']),
      updateAt: DateTime.parse(json['update_at']),
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'Nombre': nombre,
      'Password': password,
      'Email': email,
      'Telefono': telefono,
      'idRoles_fk': idRolesFk,
      'create_at': createAt.toIso8601String(),
      'update_at': updateAt.toIso8601String(),
    };
  }
}

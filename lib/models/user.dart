// lib/models/user.dart

// Necesario para formatear fechas si es necesario

class User {
  final int idUsuario;
  final String nombre;
  final String password;
  final String email;
  final String telefono;
  final int idRolesFk;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.idUsuario,
    required this.nombre,
    required this.password,
    required this.email,
    required this.telefono,
    required this.idRolesFk,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUsuario: json['idUsuario'],
      nombre: json['Nombre'],
      password: json['Password'],
      email: json['Email'],
      telefono: json['Telefono'],
      idRolesFk: json['idRoles_fk'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

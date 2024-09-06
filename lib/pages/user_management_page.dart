import 'package:flutter/material.dart';
import '../models/user.dart'; // Ajusta la ruta según tu estructura

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final List<User> _users = [];
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  User? _editingUser;

  void _addUser() {
    final name = _nameController.text;
    final email = _emailController.text;

    if (name.isEmpty || email.isEmpty) return;

    setState(() {
      if (_editingUser != null) {
        final index = _users.indexOf(_editingUser!);
        _users[index] = User(name: name, email: email);
        _editingUser = null;
      } else {
        _users.add(User(name: name, email: email));
      }
      _nameController.clear();
      _emailController.clear();
    });
  }

  void _editUser(User user) {
    _nameController.text = user.name;
    _emailController.text = user.email;
    setState(() {
      _editingUser = user;
    });
  }

  void _deleteUser(User user) {
    setState(() {
      _users.remove(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
        backgroundColor: const Color.fromARGB(255, 20, 42, 59),
        titleTextStyle: const TextStyle(
          color: Colors.white, // Cambia el color del título aquí
          fontSize: 20, // Puedes ajustar el tamaño de la fuente si lo deseas
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _emailController,
              decoration:
                  const InputDecoration(labelText: 'Correo electrónico'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    214, 99, 219, 0), // Color de fondo del botón
                foregroundColor: Colors.white, // Color del texto del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0), // Bordes redondeados del botón
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 12.0),
              ),
              child: Text(_editingUser != null
                  ? 'Actualizar Usuario'
                  : 'Añadir Usuario'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editUser(user),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteUser(user),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

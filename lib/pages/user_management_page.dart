import 'package:flutter/material.dart';
import '../models/user.dart'; // Ajusta la ruta según tu estructura
import 'login_page.dart'; // Importa la página de inicio de sesión
import 'order.dart'; // Asegúrate de importar la página de gestión de comandas

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final List<User> _users = [];
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedRole;
  User? _editingUser;

  void _addUser() {
    final name = _nameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final role = _selectedRole ?? '';

    if (name.isEmpty || email.isEmpty || phone.isEmpty || role.isEmpty) return;

    setState(() {
      if (_editingUser != null) {
        final index = _users.indexOf(_editingUser!);
        _users[index] =
            User(name: name, email: email, phone: phone, role: role);
        _editingUser = null;
      } else {
        _users.add(User(name: name, email: email, phone: phone, role: role));
      }
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _selectedRole = null;
    });
  }

  void _editUser(User user) {
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    _selectedRole = user.role;
    setState(() {
      _editingUser = user;
    });
  }

  void _deleteUser(User user) {
    setState(() {
      _users.remove(user);
    });
  }

  void _logout() {
    // Aquí deberías agregar la lógica para cerrar sesión, por ejemplo, eliminando un token de autenticación.
    // Luego redirige al usuario a la página de inicio de sesión.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _navigateToOrderManagement() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrderManagementPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
        backgroundColor: const Color.fromARGB(255, 20, 42, 59),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(
              255, 82, 100, 48), // Color verde para todo el Drawer
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 20, 42, 59), // Color más oscuro para el encabezado
                ),
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Gestión de Usuarios',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context); // Cierra el menú
                },
              ),
              ListTile(
                title: Text('Gestión de Comandas',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context); // Cierra el menú
                  _navigateToOrderManagement();
                },
              ),
            ],
          ),
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
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Teléfono'),
            ),
            DropdownButton<String>(
              value: _selectedRole,
              hint: const Text('Selecciona un rol'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue;
                });
              },
              items: <String>['Admin', 'Chef', 'Mesero']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(214, 99, 219, 0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
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
                    subtitle: Text('${user.email} - ${user.role}'),
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

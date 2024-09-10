import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user.dart'; // Ajusta la ruta según tu estructura
import 'login_page.dart'; // Importa la página de inicio de sesión
import 'order_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Asegúrate de importar la página de gestión de comandas

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final List<User> _users = [];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole;
  User? _editingUser;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nombre es requerido';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Correo electrónico es requerido';
    }
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Debe ser un campo de correo electrónico válido';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Teléfono es requerido';
    }
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Teléfono debe contener exactamente 10 números';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contraseña es requerida';
    }
    if (value.length < 6) {
      return 'Contraseña debe tener al menos 6 caracteres'; // Cambié a 6 caracteres por tu error anterior
    }
    return null;
  }

  void _addUser() {
    if (_formKey.currentState!.validate() && _selectedRole != null) {
      final name = _nameController.text;
      final email = _emailController.text;
      final phone = _phoneController.text;
      final password = _passwordController.text;
      final role = _selectedRole!;

      final hashedPassword = _hashPassword(password); // Hasheamos la contraseña

      setState(() {
        if (_editingUser != null) {
          final index = _users.indexOf(_editingUser!);
          _users[index] = User(
            name: name,
            email: email,
            phone: phone,
            role: role,
            password: hashedPassword,
          );
          _editingUser = null;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuario actualizado.'),
            ),
          );
        } else {
          _users.add(User(
            name: name,
            email: email,
            phone: phone,
            role: role,
            password: hashedPassword,
          ));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuario creado.'),
            ),
          );
        }
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _passwordController.clear(); // Limpiar el campo de la contraseña
        _selectedRole = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa todos los campos correctamente.'),
        ),
      );
    }
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password); // Convertir la contraseña en bytes
    final digest = sha256.convert(bytes); // Crear el hash
    return digest.toString().substring(
        0, 9); // Truncar el hash a 9 caracteres y lo convierte en string
  }

  void _editUser(User user) {
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    _passwordController.text =
        ''; // No mostramos la contraseña hasheada por seguridad
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

  void _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged_in'); // Elimina el estado de la sesión

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false, // Elimina todas las pantallas anteriores
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
        iconTheme: const IconThemeData(
          color: Color.fromARGB(213, 108, 238, 2),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(0),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/img/platos.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 20, 42, 59),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/img/logo2.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: const Color.fromARGB(255, 21, 128, 0),
                    ),
                    title: Text(
                      'Gestión de Usuarios',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 20, 42, 59),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context); // Cierra el menú
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.assignment,
                      color: const Color.fromARGB(255, 21, 128, 0),
                    ),
                    title: Text(
                      'Gestión de Comandas',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 20, 42, 59),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context); // Cierra el menú
                      _navigateToOrderManagement();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Formulario para añadir o actualizar usuarios
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                    validator: _validateName,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Teléfono',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: _validatePhone,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true, // Ocultar texto de la contraseña
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                    ),
                    validator: _validatePassword,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null ? 'Rol es requerido' : null,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(214, 99, 219, 0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
                    ),
                    child: Text(_editingUser != null
                        ? 'Actualizar Usuario'
                        : 'Añadir Usuario'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Usuarios',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Container(
              color: const Color.fromARGB(255, 0, 177, 38),
              height: 2,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 5,
                    child: ListTile(
                      title: Text(user.name),
                      subtitle: Text(
                          'Correo: ${user.email} \nRol: ${user.role}\nCel: ${user.phone}\nContraseña: ${user.password}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors
                                .green, // Color verde para el icono de editar
                            onPressed: () => _editUser(user),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors
                                .green, // Color verde para el icono de eliminar
                            onPressed: () => _deleteUser(user),
                          ),
                        ],
                      ),
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

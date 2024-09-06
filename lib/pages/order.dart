import 'package:flutter/material.dart';
import '../models/order.dart'; // Asegúrate de tener un modelo para Order
import 'login_page.dart'; // Asegúrate de importar la página de inicio de sesión

class OrderManagementPage extends StatefulWidget {
  const OrderManagementPage({super.key});

  @override
  _OrderManagementPageState createState() => _OrderManagementPageState();
}

class _OrderManagementPageState extends State<OrderManagementPage> {
  final List<Order> _orders = [];
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _quantityController = TextEditingController();
  final _totalPriceController = TextEditingController();
  final _menuTypeController = TextEditingController();
  final _userIdController = TextEditingController();
  final _tableIdController = TextEditingController();

  void _addOrder() {
    final date = _dateController.text;
    final time = _timeController.text;
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final totalPrice = double.tryParse(_totalPriceController.text) ?? 0.0;
    final menuType = _menuTypeController.text;
    final userId = _userIdController.text;
    final tableId = _tableIdController.text;

    if (date.isEmpty ||
        time.isEmpty ||
        quantity <= 0 ||
        totalPrice <= 0 ||
        menuType.isEmpty ||
        userId.isEmpty ||
        tableId.isEmpty) return;

    setState(() {
      _orders.add(Order(
        date: date,
        time: time,
        quantity: quantity,
        totalPrice: totalPrice,
        menuType: menuType,
        userId: userId,
        tableId: tableId,
      ));
      _dateController.clear();
      _timeController.clear();
      _quantityController.clear();
      _totalPriceController.clear();
      _menuTypeController.clear();
      _userIdController.clear();
      _tableIdController.clear();
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Comandas'),
        backgroundColor: const Color.fromARGB(
            255, 27, 52, 82), // Cambia el color de la AppBar a blanco
        foregroundColor: const Color.fromARGB(
            255, 255, 255, 255), // Cambia el color del texto de la AppBar
        actions: [
          TextButton(
            onPressed: _logout,
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(
                  color: Color.fromARGB(
                      255, 255, 255, 255)), // Color del texto del botón
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Fecha'),
            ),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'Hora'),
            ),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Cantidad de platos'),
            ),
            TextField(
              controller: _totalPriceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Precio total'),
            ),
            TextField(
              controller: _menuTypeController,
              decoration: const InputDecoration(labelText: 'Tipo de menú'),
            ),
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(labelText: 'ID Usuario'),
            ),
            TextField(
              controller: _tableIdController,
              decoration: const InputDecoration(labelText: 'ID Mesa'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    214, 99, 219, 0), // Color de fondo del botón
                foregroundColor: Colors.white, // Color del texto del botón
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Bordes redondeados
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 12.0),
              ),
              child: const Text('Añadir Comanda'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  final order = _orders[index];
                  return ListTile(
                    title: Text('Fecha: ${order.date}, Hora: ${order.time}'),
                    subtitle: Text(
                        'Cantidad: ${order.quantity}, Precio: \$${order.totalPrice}, Menú: ${order.menuType}, Usuario: ${order.userId}, Mesa: ${order.tableId}'),
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

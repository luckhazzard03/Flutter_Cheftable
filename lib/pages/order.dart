import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa intl para el formato de fecha
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

  Order? _editingOrder;

  final List<String> _menuTypes = ['Corriente', 'Ejecutivo', 'Especial'];
  final List<String> _tableIds =
      List.generate(10, (index) => 'Mesa ${index + 1}');
  final List<String> _userIds =
      List.generate(10, (index) => 'Mesero ${index + 1}');
  final List<String> _quantities =
      List.generate(20, (index) => (index + 1).toString());

  final _dateFormat = DateFormat('yyyy-MM-dd');
  final _timeFormat = DateFormat('HH:mm');

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedQuantity;
  String? _selectedMenuType;
  String? _selectedUserId;
  String? _selectedTableId;

  void _addOrder() {
    final date = _dateController.text;
    final time = _timeController.text;
    final quantity = int.tryParse(_selectedQuantity ?? '') ?? 0;
    final pricePerItem = double.tryParse(_totalPriceController.text) ?? 0.0;
    final totalPrice = quantity * pricePerItem;
    final menuType = _selectedMenuType ?? '';
    final userId = _selectedUserId ?? '';
    final tableId = _selectedTableId ?? '';

    if (date.isEmpty ||
        time.isEmpty ||
        quantity <= 0 ||
        pricePerItem <= 0 ||
        menuType.isEmpty ||
        userId.isEmpty ||
        tableId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              const Text('Por favor, completa todos los campos correctamente.'),
        ),
      );
      return;
    }

    setState(() {
      if (_editingOrder == null) {
        _orders.add(Order(
          date: date,
          time: time,
          quantity: quantity,
          totalPrice: totalPrice,
          menuType: menuType,
          userId: userId,
          tableId: tableId,
        ));
      } else {
        final index = _orders.indexOf(_editingOrder!);
        if (index != -1) {
          _orders[index] = Order(
            date: date,
            time: time,
            quantity: quantity,
            totalPrice: totalPrice,
            menuType: menuType,
            userId: userId,
            tableId: tableId,
          );
        }
        _editingOrder = null;
      }

      _clearFields();
    });
  }

  void _editOrder(Order order) {
    setState(() {
      _editingOrder = order;
      _dateController.text = order.date;
      _timeController.text = order.time;
      _selectedQuantity = order.quantity.toString();
      _totalPriceController.text =
          (order.totalPrice / order.quantity).toString(); // Set price per item
      _selectedMenuType = order.menuType;
      _selectedUserId = order.userId;
      _selectedTableId = order.tableId;
    });
  }

  void _deleteOrder(Order order) {
    setState(() {
      _orders.remove(order);
    });
  }

  void _clearFields() {
    _dateController.clear();
    _timeController.clear();
    _quantityController.clear();
    _totalPriceController.clear();
    _menuTypeController.clear();
    _userIdController.clear();
    _tableIdController.clear();
    _selectedQuantity = null;
    _selectedMenuType = null;
    _selectedUserId = null;
    _selectedTableId = null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _dateFormat.format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false, // Elimina todas las pantallas anteriores
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Comandas'),
        backgroundColor: const Color.fromARGB(255, 20, 42, 59),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Fecha'),
              onTap: () => _selectDate(context),
              readOnly: true,
            ),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'Hora'),
              onTap: () => _selectTime(context),
              readOnly: true,
            ),
            DropdownButtonFormField<String>(
              value: _selectedQuantity,
              items: _quantities.map((quantity) {
                return DropdownMenuItem<String>(
                  value: quantity,
                  child: Text(quantity),
                );
              }).toList(),
              decoration:
                  const InputDecoration(labelText: 'Cantidad de platos'),
              onChanged: (value) {
                setState(() {
                  _selectedQuantity = value;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: _selectedMenuType,
              items: _menuTypes.map((menuType) {
                return DropdownMenuItem<String>(
                  value: menuType,
                  child: Text(menuType),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Tipo de menú'),
              onChanged: (value) {
                setState(() {
                  _selectedMenuType = value;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: _selectedTableId,
              items: _tableIds.map((tableId) {
                return DropdownMenuItem<String>(
                  value: tableId,
                  child: Text(tableId),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'ID Mesa'),
              onChanged: (value) {
                setState(() {
                  _selectedTableId = value;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: _selectedUserId,
              items: _userIds.map((userId) {
                return DropdownMenuItem<String>(
                  value: userId,
                  child: Text(userId),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'ID Usuario'),
              onChanged: (value) {
                setState(() {
                  _selectedUserId = value;
                });
              },
            ),
            TextField(
              controller: _totalPriceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Precio unitario'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(214, 99, 219, 0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 12.0),
              ),
              child: Text(_editingOrder == null
                  ? 'Añadir Comanda'
                  : 'Actualizar Comanda'),
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editOrder(order),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteOrder(order),
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

// lib/models/order.dart
class Order {
  String menuType;
  String drink;
  double price;
  DateTime date;
  String waiter;

  Order({
    required this.menuType,
    required this.drink,
    required this.price,
    required this.date,
    required this.waiter,
  });
}

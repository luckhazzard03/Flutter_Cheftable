class Order {
  final String date;
  final String time;
  final int quantity;
  final double totalPrice;
  final String menuType;
  final String userId;
  final String tableId;

  Order({
    required this.date,
    required this.time,
    required this.quantity,
    required this.totalPrice,
    required this.menuType,
    required this.userId,
    required this.tableId,
  });
}

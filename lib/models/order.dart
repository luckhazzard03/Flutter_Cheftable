import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart'; // Generado automáticamente por build_runner

@JsonSerializable()
class Order {
  @JsonKey(name: 'Comanda_id')
  final int id;
  
  final String fecha;
  final String hora;
  @JsonKey(name: 'Total_platos')
  final int totalPlatos;
  @JsonKey(name: 'Precio_Total')
  final double precioTotal;
  @JsonKey(name: 'Tipo_Menu')
  final String tipoMenu;
  @JsonKey(name: 'idUsuario_fk')
  final int idUsuarioFk;
  @JsonKey(name: 'idMesa_fk')
  final int idMesaFk;
  @JsonKey(name: 'create_at')
  final String createAt;
  @JsonKey(name: 'update_at')
  final String updateAt;

  Order({
    required this.id,
    required this.fecha,
    required this.hora,
    required this.totalPlatos,
    required this.precioTotal,
    required this.tipoMenu,
    required this.idUsuarioFk,
    required this.idMesaFk,
    required this.createAt,
    required this.updateAt,
  });

  // Convierta un JSON a una instancia de Order
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  // Convierta una instancia de Order a JSON
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

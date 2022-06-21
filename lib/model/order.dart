import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String date;
  final String start_time;
  final String end_time;
  final String address;
  final int service_id;
  final int quantity;

  const Order(
      {
        this.date,
        this.start_time,
        this.end_time,
        this.address,
        this.service_id,
        this.quantity
      });

  @override
  List<Object> get props =>
      [date,start_time,end_time,address,service_id,quantity];

  static Order fromJson(dynamic json) {
    return Order(
        date: json['date'],
        start_time: json['start_time'],
        end_time: json['end_time'],
        address: json['address'],
        service_id: json['service_id'],
        quantity: json['quantity']
    );

  }

  @override
  String toString() => 'ServiceModel id: $quantity';
}

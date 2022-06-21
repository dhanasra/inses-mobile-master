import 'package:equatable/equatable.dart';

class PaymentHistoryModel extends Equatable {
  final String id;

  const PaymentHistoryModel(
      {this.id,});

  @override
  List<Object> get props => [id];

  static PaymentHistoryModel fromJson(dynamic json) {
    return PaymentHistoryModel(
        id: json['id'],);
  }

  @override
  String toString() => 'ServiceModel id: $id';
}
import 'package:equatable/equatable.dart';

class AdditionalModel extends Equatable {
  final int id;
  final String description;
  final String price;

  const AdditionalModel(
      { this.id,
        this.description,
        this.price,});

  @override
  List<Object> get props =>
      [price,description];

  static AdditionalModel fromJson(dynamic json) {
    return AdditionalModel(
        description: json['description'],
        price: json['price']
    );
  }

  @override
  String toString() => 'ServiceModel id: $price';
}

import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String image;

  const CategoryModel(
      { this.id,
        this.name,
        this.image,});

  @override
  List<Object> get props =>
      [image,name];

  static CategoryModel fromJson(dynamic json) {
    return CategoryModel(
        name: json['name'],
        image: json['image']
    );
  }

  @override
  String toString() => 'ServiceModel id: $image';
}

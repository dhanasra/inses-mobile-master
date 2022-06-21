import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String name;
  final String img;
  final String date;
  final int stars;
  final String review;
  

  const ReviewModel(
      {this.name,
        this.review,
        this.img,
        this.date,
        this.stars
      });

  @override
  List<Object> get props =>
      [img,name,review];

  static ReviewModel fromJson(dynamic json) {
    return ReviewModel(
        name: json['name'],
        review: json['review'],
        date: json['date'],
        stars: json['stars'],
        img: json['img']);
  }

  @override
  String toString() => 'ServiceModel id: $img';
}

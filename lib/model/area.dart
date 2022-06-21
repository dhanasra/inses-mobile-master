import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class AreaModel extends Equatable {
  final String area;
  final Position position;

  const AreaModel(
      {
        this.area,
        this.position,
        });

  @override
  List<Object> get props =>
      [area,position];

  static AreaModel fromJson(dynamic json) {
    return AreaModel(
        area: json['area'],
        position: json['position'],
        );
  }

  @override
  String toString() => 'ServiceModel id: $area';
}

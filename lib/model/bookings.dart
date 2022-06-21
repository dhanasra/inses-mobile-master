import 'package:equatable/equatable.dart';
import 'package:inses_app/model/additional.dart';

class BookingModel extends Equatable {
  final int id;
  final String name;
  final String categoryName;
  final String icon;
  final String status;
  final String payMethod;
  final String payStatus;
  final String date;
  final String startTime;
  final String endTime;
  final String address;
  final String userName;
  final String userPhone;
  final bool reviewed;
  final int quantity;
  final int additionalPrice;
  final int additionalId;
  final String additionalDesc;
  final int totalPrice;

  const BookingModel(
      {this.id,this.startTime,this.endTime,this.address,this.date,this.quantity,this.icon,this.name,this.status,this.totalPrice,
      this.categoryName,this.userName,this.userPhone,this.payMethod,this.reviewed,this.payStatus,this.additionalId,this.additionalDesc,this.additionalPrice});

  @override
  List<Object> get props => [id,status,startTime,endTime,address,additionalId,additionalPrice,additionalDesc,date,quantity,icon,name,totalPrice,categoryName,payStatus,payMethod];

  static BookingModel fromJson(dynamic json) {
    return BookingModel(
      id: json['id'],
      name:json['name'],
      categoryName: json['categoryName'],
      icon: json['icon'],
      status: json['status'],
      payMethod: json['payMethod'],
      payStatus: json['payStatus'],
      date: json['date'],
      userName: json['userName'],
      userPhone: json['userPhone'],
      startTime: json['startTime'],
        reviewed: json['reviewed'],
        endTime: json['endTime'],
      address: json['address'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
      additionalDesc: json['additionalDesc'],
      additionalPrice: json['additionalPrice'],
        additionalId: json['additionalId']
    );
  }

  @override
  String toString() => 'ServiceModel id: $id';
}
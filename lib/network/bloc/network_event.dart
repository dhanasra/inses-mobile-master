import 'dart:io';

import 'package:inses_app/model/order.dart';
import 'package:inses_app/views/login.dart';

abstract class NetworkEvent {
  const NetworkEvent();
}

class AddUser extends NetworkEvent {
  final String name;
  final String phone;
  final String password;

  AddUser({this.name,this.phone,this.password});
}

class LoginUser extends NetworkEvent {
  final String phone;
  final String password;

  LoginUser({this.phone,this.password});
}

class Logout extends NetworkEvent {}

class GetUserDetails extends NetworkEvent {}

class AuthExpired extends NetworkEvent {}

class UpdateProfile extends NetworkEvent {
  final String name;
  final String phone;

  UpdateProfile({this.name,this.phone});
}

class UpdatePassword extends NetworkEvent {
  final String old;
  final String password;

  UpdatePassword({this.old,this.password});
}

class AddUserAddress extends NetworkEvent {
  final String address;

  AddUserAddress({this.address});
}


class GetCategoryServices extends NetworkEvent {
  final int id;

  GetCategoryServices({this.id});
}

class GetUserAddress extends NetworkEvent {}

class GetServices extends NetworkEvent {}

class GetOffers extends NetworkEvent {}

class AddServiceEvent extends NetworkEvent {
  final int categoryId;
  final int price;
  final String name;
  final File icon;
  final File image;

  AddServiceEvent({this.categoryId,this.name,this.price,this.image,this.icon});
}


class EditService extends NetworkEvent {
  final int id;
  final int categoryId;
  final int price;
  final String name;
  final File icon;
  final File image;

  EditService({this.id,this.categoryId,this.name,this.price,this.image,this.icon});
}

class DeleteService extends NetworkEvent {
  final int serviceId;
  DeleteService({this.serviceId});
}

class AddCategoryEvent extends NetworkEvent {
  final String name;
  final File image;

  AddCategoryEvent({this.name,this.image});
}

class AddOfferEvent extends NetworkEvent {
  final int price;
  final int offer;
  final String text;
  final File image;

  AddOfferEvent({this.image,this.price,this.text,this.offer});
}

class EditCategory extends NetworkEvent {
  final int categoryId;
  final String name;
  final File image;

  EditCategory({this.name,this.image,this.categoryId});
}

class EditOfferEvent extends NetworkEvent {
  final int id;
  final int old;
  final int price;
  final String txt;
  final File image;

  EditOfferEvent({this.txt,this.image,this.price,this.old,this.id});
}


class DeleteCategory extends NetworkEvent {
  final int categoryId;
  DeleteCategory({this.categoryId});
}

class DeleteOffer extends NetworkEvent {
  final int id;
  DeleteOffer({this.id});
}

class GetCategories extends NetworkEvent {}

class GetPaymentHistory extends NetworkEvent {}

class GetBookings extends NetworkEvent {}

class GetBookingHistory extends NetworkEvent {}

class GetReview extends NetworkEvent {}

class AddMessage extends NetworkEvent{
  final String message;
  AddMessage({this.message});
}

class UpdatePhoneNumber extends NetworkEvent{
  final String number;
  UpdatePhoneNumber({this.number});
}

class BookService extends NetworkEvent {
  final Order order;

  BookService({this.order});
}

class UpdatePaymentStatus extends NetworkEvent {
  final int orderId;
  final String paymentId;
  final String method;

  UpdatePaymentStatus({this.orderId,this.paymentId,this.method});
}

class AddAdditionalCharge extends NetworkEvent {
  final int orderId;
  final int price;
  final String desc;

  AddAdditionalCharge({this.orderId,this.price,this.desc});
}

class AddReview extends NetworkEvent {
  final int id;
  final int rating;
  final String comment;

  AddReview({this.id,this.rating,this.comment});
}


class ApproveOrder extends NetworkEvent {
  final int categoryId;
  ApproveOrder({this.categoryId});
}

class CompleteOrder extends NetworkEvent {
  final int categoryId;
  CompleteOrder({this.categoryId});
}

class GetBookingDetails extends NetworkEvent {
  final int id;
  GetBookingDetails({this.id});
}

class RemoveAdditionalCharge extends NetworkEvent {
  final int id;
  RemoveAdditionalCharge({this.id});
}
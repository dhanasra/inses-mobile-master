import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/model/bookings.dart';
import 'package:inses_app/model/category.dart';
import 'package:inses_app/model/offer.dart';
import 'package:inses_app/model/order.dart';
import 'package:inses_app/model/payment_history.dart';
import 'package:inses_app/model/review.dart';
import 'package:inses_app/model/service.dart';
import 'package:inses_app/network/app_api_client.dart';
import 'package:inses_app/network/bloc/network_event.dart';
import 'package:inses_app/network/bloc/network_state.dart';

class AppRepository {
  final AppApiClient appApiClient;

  AppRepository({@required this.appApiClient})
      : assert(appApiClient != null);

  Future<String> addUser(String name,String phone,String password) async {
    return await appApiClient.addUser(name, phone, password);
  }

  Future<String> userLogin(String phone,String password) async {
    return await appApiClient.userLogin(phone, password);
  }

  Future<String> logout() async {
    return await appApiClient.logout();
  }

  Future<NetworkState> getUserDetails() async {
    return await appApiClient.getUserDetails();
  }

  Future<String> updateProfile(String name,String phone) async {
    return await appApiClient.updateProfile(name, phone);
  }

  Future<String> updatePassword(String old,String password) async {
    return await appApiClient.updatePassword(old,password);
  }

  Future<String> addUserAddress(String address) async {
    return await appApiClient.addUserAddress(address);
  }

  Future<String> getUserAddress() async {
    return await appApiClient.getUserAddress();
  }

  Future<List<CategoryModel>> getCategories() async {
    return await appApiClient.getCategories();
  }

  Future<List<OfferModel>> getOffers() async {
    return await appApiClient.getOffers();
  }


  Future<List<ServiceModel>> getCategoryServices(int id) async {
    return await appApiClient.getCategoryServices(id);
  }

  Future<List<ServiceModel>> getServices() async {
    return await appApiClient.getServices();
  }

  Future<String> addOffer({String txt,int price,int offer,File image}) async {
    return await appApiClient.addOffer(
        text: txt,
        price: price,
        offer: offer,
        image: image
    );
  }

  Future<String> editOffer({String txt,int id,int price,int offer,File image}) async {
    return await appApiClient.editOffer(
        text: txt,
        id: id,
        price: price,
        offer: offer,
        image: image
    );
  }

  Future<String> addService({String name,int categoryId,int price,File icon,File image}) async {
    return await appApiClient.addService(
        name: name,
        categoryId: categoryId,
        price: price,
        icon: icon,
        image: image
    );
  }

  Future<String> editService({String name,int id,int categoryId,int price,File icon,File image}) async {
    return await appApiClient.editService(
      name: name,
      id: id,
      categoryId: categoryId,
      price: price,
      icon: icon,
      image: image
    );
  }

  Future<String> deleteService({int serviceId}) async {
    return await appApiClient.deleteService(
        serviceId: serviceId
    );
  }

  Future<String> deleteOffer({int id}) async {
    return await appApiClient.deleteOffer(
        id: id
    );
  }

  Future<String> addCategory({String name,File image}) async {
    return await appApiClient.addCategory(
        name: name,
        image: image
    );
  }

  Future<String> editCategory({String name,int categoryId,File image}) async {
    return await appApiClient.editCategory(
        name: name,
        categoryId: categoryId,
        image: image
    );
  }

  Future<String> deleteCategory({int categoryId}) async {
    return await appApiClient.deleteCategory(
        categoryId: categoryId
    );
  }


  Future<List<BookingModel>> getBookings(String type) async {
    return await appApiClient.getBookings(type);
  }

  Future<List<BookingModel>> getBookingHistory(String type) async {
    return await appApiClient.getBookings(type);
  }

  Future<String> updateOrder(int id,String status) async {
    return await appApiClient.updateOrder(id, status);
  }

  Future<String> addMessage(String message) async {
    return await appApiClient.addMessage(message);
  }

  Future<String> deleteAdditional(int id) async {
    return await appApiClient.deleteAdditional(id);
  }


  Future<String> bookService(Order order) async {
    return await appApiClient.bookService(order);
  }

  Future<String> paymentStatus(int orderId,String paymentId,String method) async {
    return await appApiClient.paymentStatus(orderId,paymentId,method);
  }

  Future<String> addAdditionalCharges(int orderId,int price,String desc) async {
    return await appApiClient.addAdditionalCharge(orderId, price, desc);
  }

  Future<String> addReview(int orderId,int rating,String comment) async {
    return await appApiClient.addReview(id:orderId,rating: rating,comment:comment);
  }

  Future<List<ReviewModel>> getReviews() async {
    return await appApiClient.getReviews();
  }

  Future<BookingModel> getBookingDetails(int orderId) async {
    return await appApiClient.getBooking(orderId);
  }
}
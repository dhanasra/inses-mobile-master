import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/model/bookings.dart';
import 'package:intl/intl.dart';

class OrderViewModel {
  static OrderViewModel _instance;
  var addressController;
  FocusNode addressFocus;

  DateFormat dayformatter = DateFormat('MMM');
  DateFormat dateformatter = DateFormat('dd');
  DateFormat dateTimeformatter = DateFormat('dd MMM');

  static int categoryId ;
  static int serviceId ;
  static int orderId ;
  static String serviceIcon = '' ;
  static String serviceImage = '' ;
  static String category='';
  static String address = '';
  static String service = '';
  static int noOfService = 0;
  static int totalPrice = 0;
  static int basePrice = 100;
  static bool load1 = false;
  static bool load2 = false;
  static bool load3 = false;
  static bool load4 = false;
  static String date;
  static String time = '';
  static String startTime = '';
  static String endTime = '';
  static String isCash = '';
  static String isPaid = '';
  static BookingModel booking ;

  factory OrderViewModel(App app) {
    _instance ??= OrderViewModel._internal();
    return _instance;
  }

  OrderViewModel._internal() {
    _init();
  }

  void _init() {
    addressFocus = FocusNode();
    addressController = TextEditingController(text: "");

    addressController.addListener(() {
      String password = addressController.text.toString();
      if (password.isNotEmpty && (password[0] == " " || password[0] == "."))
        addressController.text = "";
    });
  }

  Future<void> getPosition() async {
    bool locationPermission = await App().locationPermission();
    if (locationPermission) {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {

      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {

        }
      }
      Position position = await Geolocator.getCurrentPosition();
      List<Address> address = await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(position.latitude, position.longitude));
      addressController.text = address[0].addressLine.toString();
    }
  }

}
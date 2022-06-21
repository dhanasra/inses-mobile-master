import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/model/category.dart';
import 'package:inses_app/model/offer.dart';
import 'package:inses_app/model/service.dart';

class EditViewModel{
  static EditViewModel _instance;

  static int type;

  static String serviceImage;
  static int rating = 5;
  static File icon;
  static File image;
  var priceController;
  var nameController;
  var phoneController;
  var addressController;
  var oldPriceController;
  var offerPriceController;

  static ServiceModel service;
  static CategoryModel category;
  static OfferModel offer;

  factory EditViewModel(App app){
    _instance ??= EditViewModel._internal();
    return _instance;
  }

  EditViewModel._internal(){
    init();
  }

  void init(){
    priceController = TextEditingController(text: "");
    nameController = TextEditingController(text: "");
    addressController = TextEditingController(text: "");
    phoneController = TextEditingController(text: "");
    oldPriceController = TextEditingController(text: "");
    offerPriceController = TextEditingController(text: "");

    priceController.addListener(() {
      String price = priceController.text.toString();
      if (price.isNotEmpty && (price[0] == " " || price[0] == "."))
        priceController.text = "";
    });

    nameController.addListener(() {
      String fName = nameController.text.toString();
      if (fName.isNotEmpty && (fName[0] == " " || fName[0] == "."))
        nameController.text = "";
    });

    oldPriceController.addListener(() {
      String fName = oldPriceController.text.toString();
      if (fName.isNotEmpty && (fName[0] == " " || fName[0] == "."))
        oldPriceController.text = "";
    });

    offerPriceController.addListener(() {
      String fName = offerPriceController.text.toString();
      if (fName.isNotEmpty && (fName[0] == " " || fName[0] == "."))
        offerPriceController.text = "";
    });

    phoneController.addListener(() {
      String fName = phoneController.text.toString();
      if (fName.isNotEmpty && (fName[0] == " " || fName[0] == "."))
        phoneController.text = "";
    });

    addressController.addListener(() {
      String fName = addressController.text.toString();
      if (fName.isNotEmpty && (fName[0] == " " || fName[0] == "."))
        addressController.text = "";
    });
  }
}
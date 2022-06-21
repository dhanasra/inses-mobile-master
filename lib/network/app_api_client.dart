import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:inses_app/database/app_preferences.dart';
import 'package:inses_app/database/constants.dart';
import 'package:inses_app/model/bookings.dart';
import 'package:inses_app/model/category.dart';
import 'package:inses_app/model/offer.dart';
import 'package:inses_app/model/order.dart';
import 'package:inses_app/model/payment_history.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:inses_app/model/review.dart';
import 'package:inses_app/model/service.dart';
import 'package:inses_app/network/bloc/network_state.dart';
import 'package:inses_app/utils/url.dart';
import 'package:http/http.dart' as http;
import 'package:inses_app/view_models/home_view_model.dart';
import 'package:inses_app/view_models/order_view_model.dart';
import 'package:inses_app/view_models/profile_view_model.dart';

class AppApiClient {
  final _baseUrl = AppUrl.BASE_URL;
  final http.Client httpClient;
  AppApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<String> addUser(String name,String phone,String password) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${_baseUrl}auth/register'));

    request.body = jsonEncode({
      "name": name,
      "phone": phone,
      "password": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();

    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status = json['status'];
      print(status);
      if(status==200){
        String token = json['data']['token']['token'];
        String rToken = json['data']['token']['refreshToken'];

        int roleId = json['data']['user']['role_id'];

        await AppPreferences().setToken(token: token);
        await AppPreferences().setRefreshToken(refreshToken: rToken);
        await AppPreferences().setName(firstName: name);
        await AppPreferences().setPhoneNumber(phone: phone);
        await AppPreferences().setLoginStatus(status: roleId==1?AppConstants.LOGGED_IN_ADMIN:AppConstants.LOGGED_IN);

        await updateFCMToken(rToken);

        return "success";
      }else if(status==422){
        String error = json['data']['errors'][0]['rule'];
        if(error=="alreadyExists"){
          return "Phone number already exists.";
        }else{
          return "Error";
        }
      }
    }
    else {
      print(response.reasonPhrase);
      return "Error";
    }

  }

  Future<void> updateFCMToken(String rToken)async{
    String token = await FirebaseMessaging.instance.getToken();
    var headers = {
      'Content-Type': 'application/json',
      'x-refresh-token': rToken
    };
    var request = http.Request('POST', Uri.parse('${_baseUrl}fcm-token'));
    request.body = jsonEncode({
      "token": token
    });
    print(token);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();
  }

  Future<String> userLogin(String phone,String password) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${_baseUrl}auth/login'));

    request.body = jsonEncode({
      "phone": phone,
      "password": password
    });
    request.headers.addAll(headers);
    print(1);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();
    print(1);
    print(responseStr);
    Map<String, dynamic> json = jsonDecode(responseStr);
    print(1);
    if (response.statusCode == 200) {
      int status = json['status'];
      print(status);
      if(status==200){
        String token = json['data']['token']['token'];
        String rToken = json['data']['token']['refreshToken'];

        int roleId = json['data']['user']['role_id'];
        String name = json['data']['user']['name'];
        String phone = json['data']['user']['phone'];

        ProfileViewModel.name = name;
        ProfileViewModel.phone = phone;

        await AppPreferences().setToken(token: token);
        await AppPreferences().setRefreshToken(refreshToken: rToken);
        await AppPreferences().setName(firstName: name);
        await AppPreferences().setPhoneNumber(phone: phone);

        await updateFCMToken(rToken);

        String address = await getUserAddress();
        ProfileViewModel.address = address;

        await AppPreferences().setLoginStatus(status: roleId==1?AppConstants.LOGGED_IN_ADMIN:AppConstants.LOGGED_IN);
        HomeViewModel.loginStatus = roleId==1?AppConstants.LOGGED_IN_ADMIN:AppConstants.LOGGED_IN;
        print(roleId);

        if(roleId==1){
          return "1";
        }else{
          return "2";
        }
      }else if(status==422){
        String error = json['data']['errors'][0]['rule'];
        print(error);
        if(error=="invalid"){
          return "Invalid password";
        }else{
          return "Error";
        }
      }
    }
    else {
      print(response.reasonPhrase);
      return "Error";
    }
  }

  Future<String> logout() async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token
    };
    var request = http.Request('POST', Uri.parse('${_baseUrl}auth/logout'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();

    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status = json['status'];
      print(status);
      if(status==200){
        await AppPreferences().setLoginStatus(status: AppConstants.LOGGED_OUT);
        return "success";
      }
    }
    else {
      print(response.reasonPhrase);
      return "Error";
    }
  }

  Future<NetworkState> getUserDetails() async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token
    };
    var request = http.Request('GET', Uri.parse('${_baseUrl}user/me'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();

    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status =  json['status'];
      if(status==200){
        String name = json['data']['user']['name'];
        String phone = json['data']['user']['phone'];
        return GotUserDetails(name: name,phone: phone);
      }
    }
    else {
      print(response.reasonPhrase);
      return Error(error: 'Error');
    }
  }

  Future<String> updateProfile(String name,String phone) async {
    print(name);
    print(phone);
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json'
    };
    var body = jsonEncode({
      "name":name,
      "phone":phone
    });
    var response = await http.post(Uri.parse('${_baseUrl}user/update-profile'),body: body,headers: headers);

    String responseStr = response.body.toString();

    Map<String, dynamic> json1 = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status =  json1['status'];
      if(status==200){
        await AppPreferences().setName(firstName: name);
        await AppPreferences().setPhoneNumber(phone: phone);
        return 'success';
      }
    }
    else {
      print(response.reasonPhrase);
      return 'Error';
    }
  }

  Future<String> updatePassword(String old,String password) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json'
    };
    var body = jsonEncode({
      "old_password":old,
      "password": password
    });
    var response = await http.post(Uri.parse('${_baseUrl}user/update-password'),body: body,headers: headers);

    String responseStr = response.body.toString();
    print(responseStr);
    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status =  json['status'];
      if(status==200){
        return 'success';
      }
    }
    else {
      print(response.reasonPhrase);
      return 'Error';
    }
  }

  Future<String> addUserAddress(String address) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json'
    };
    var body = jsonEncode({
      "address": address
    });
    var response = await http.post(Uri.parse('${_baseUrl}user-address'),body: body,headers: headers);

    String responseStr = response.body.toString();
    print(responseStr);

    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status =  json['status'];
      if(status==200){
        return 'success';
      }
    }
    else {
      print(response.reasonPhrase);
      return 'Error';
    }
  }

  Future<String> getUserAddress() async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('${_baseUrl}user-address'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();

    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status =  json['status'];
      if(status==200){
        try{
          print(1);
          String address = json['data']['userAddresses'][0]['address'];
          print(1);
          return address;
        }catch(e){
          print(e);
          return "";
        }
      }
    }
    else {
      print(response.reasonPhrase);
      return 'Error';
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = [];
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('${_baseUrl}category'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();

    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status =  json['status'];
      if(status==200){
        List category = json['data']['categories'];
        category.forEach((element) {
          categories.add(
            CategoryModel(
              id: element['id'],
              name: element['name'],
              image: element['image']
            )
          );
        });
        return categories;
      }
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }

  Future<List<OfferModel>> getOffers() async {
    List<OfferModel> offers = [];
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('${_baseUrl}banner'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();

    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status =  json['status'];
      if(status==200){
        List category = json['data']['banners'];
        category.forEach((element) {
          offers.add(
              OfferModel(
                  id: element['id'],
                  old: element['price'].toString(),
                  offer: element['offer_price'].toString(),
                  txt: element['text'],
                  img: element['image']
              )
          );
        });
        return offers;
      }
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }


  Future<List<ServiceModel>> getCategoryServices(int id) async {
    final List<ServiceModel> services = [];
    print(id.toString());
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('${_baseUrl}category/$id/services'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();
    print(responseStr);

    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status =  json['status'];
      if(status==200){
        List category = json['data']['services'];
        category.forEach((element) {
          services.add(
              ServiceModel(
                  id: element['id'],
                  name: element['name'],
                  image: element['image'],
                  icon: element['icon'],
                  price: element['price']
              )
          );
        });
        return services;
      }
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }

  Future<List<ServiceModel>> getServices() async {
    final List<ServiceModel> services = [];
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('${_baseUrl}service'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();
    print(responseStr);

    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status =  json['status'];
      if(status==200){
        List category = json['data']['services'];
        category.forEach((element) {
          services.add(
              ServiceModel(
                  id: element['id'],
                  name: element['name'],
                  image: element['image'],
                  icon: element['icon'],
                  price: element['price'],
                categoryId: element['category_id']
              )
          );
        });
        return services;
      }
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }

  Future<String> addService({int categoryId,String name,int price,File icon,File image}) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json/octet-stream',
    };
    try {
      print('${_baseUrl}service');

      final bytes = icon.readAsBytesSync().lengthInBytes;
      final kb = bytes / 1024;
      final mb = kb / 1024;

      final bytes1 = image.readAsBytesSync().lengthInBytes;
      final kb1 = bytes1 / 1024;
      final mb1 = kb1 / 1024;

      print(mb.toString()+" "+mb1.toString());

      if(mb>1){
        return "icon error";
      }else if(mb1>1){
        return "image error";
      }else {
        var request = http.MultipartRequest(
            'POST', Uri.parse('${_baseUrl}service'))
          ..fields['name'] = name
          ..fields['category_id'] = categoryId.toString()
          ..fields['price'] = price.toString()
          ..files.add(await http.MultipartFile.fromPath('icon', icon.path,
            contentType: MediaType('icon', 'png/jpeg/jpg'),
          ))
          ..files.add(await http.MultipartFile.fromPath('image', image.path,
            contentType: MediaType('image', 'png/jpeg/jpg'),
          ));

        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        String responseStr = await response.stream.bytesToString();

        print(responseStr);

        Map<String, dynamic> json = jsonDecode(responseStr);

        if (response.statusCode == 200) {
          int status = json['status'];
          if (status == 200) {
            return 'success';
          }
        }
        else {
          print(response.statusCode);
          print(response.hashCode);
          print(response.reasonPhrase);
          return 'Error';
        }
      }

    }catch(e){
      print(e.toString());
      print(e.toString().contains("<center><h1>413 Request Entity Too Large</h1></center>"));
    }

  }

  Future<String> editService({int categoryId,int id,String name,int price,File icon,File image}) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json/octet-stream',
    };
    print(id);
    try {
      print('${_baseUrl}service/$id');
      var request;
      if(icon ==null && image==null){
        request = http.MultipartRequest('PUT', Uri.parse('${_baseUrl}service/$id'))
          ..fields['name'] = name
          ..fields['category_id'] = categoryId.toString()
          ..fields['price'] = price.toString();
      }else if(icon==null){
        request = http.MultipartRequest('PUT', Uri.parse('${_baseUrl}service/$id'))
          ..fields['name'] = name
          ..fields['category_id'] = categoryId.toString()
          ..fields['price'] = price.toString()
          ..files.add(await http.MultipartFile.fromPath('image', image.path,
            contentType:MediaType('image','png/jpeg/jpg'),
          ));
      }else if(image==null){
        request = http.MultipartRequest('PUT', Uri.parse('${_baseUrl}service/$id'))
          ..fields['name'] = name
          ..fields['category_id'] = categoryId.toString()
          ..fields['price'] = price.toString()

          ..files.add(await http.MultipartFile.fromPath('icon', icon.path,
            contentType:MediaType('image','png/jpeg/jpg'),)
          );
      }else{
        request = http.MultipartRequest('PUT', Uri.parse('${_baseUrl}service/$id'))
          ..fields['name'] = name
          ..fields['category_id'] = categoryId.toString()
          ..fields['price'] = price.toString()

          ..files.add(await http.MultipartFile.fromPath('icon', icon.path,
            contentType:MediaType('image','png/jpeg/jpg'),)
          )
          ..files.add(await http.MultipartFile.fromPath('image', image.path,
            contentType:MediaType('image','png/jpeg/jpg'),
          ));
      }

        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        String responseStr = await response.stream.bytesToString();

        print(responseStr);

        Map<String, dynamic> json = jsonDecode(responseStr);

        if (response.statusCode == 200) {
          int status = json['status'];
          if (status == 200) {
            return 'success';
          }
        }
        else {
          print(response.reasonPhrase);
          return 'Error';
        }

    }catch(e){
      print(e);
    }

  }

  Future<String> deleteService({int serviceId}) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json',
    };
    try {
      print('${_baseUrl}category');


      var request = http.Request('DELETE', Uri.parse('${_baseUrl}service/$serviceId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      String responseStr = await response.stream.bytesToString();

      print(responseStr);

      Map<String, dynamic> json = jsonDecode(responseStr);

      if (response.statusCode == 200) {
        int status = json['status'];
        if (status == 200) {
          return 'success';
        }
      }
      else {
        print(response.reasonPhrase);
        return 'Error';
      }

    }catch(e){
      print(e);
    }

  }

  Future<String> deleteAdditional(int id) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json',
    };
    try {
      print('${_baseUrl}additional-charge/$id');


      var request = http.Request('DELETE', Uri.parse('${_baseUrl}additional-charge/$id'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      String responseStr = await response.stream.bytesToString();

      print(responseStr);

      Map<String, dynamic> json = jsonDecode(responseStr);

      if (response.statusCode == 200) {
        int status = json['status'];
        if (status == 200) {
          return 'success';
        }
      }
      else {
        print(response.reasonPhrase);
        return 'Error';
      }

    }catch(e){
      print(e);
    }

  }

  Future<String> addCategory({String name,File image}) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json/octet-stream',
    };
    try {
      print('${_baseUrl}category');
      final bytes1 = image.readAsBytesSync().lengthInBytes;
      final kb1 = bytes1 / 1024;
      final mb1 = kb1 / 1024;

      print(mb1.toString()+" "+mb1.toString());

       if(mb1>1){
        return "image error";
      }else {
         var request = http.MultipartRequest(
             'POST', Uri.parse('${_baseUrl}category'))
           ..fields['name'] = name
           ..files.add(await http.MultipartFile.fromPath('image', image.path,
             contentType: MediaType('image', 'png/jpeg/jpg'),
           ));

         request.headers.addAll(headers);

         http.StreamedResponse response = await request.send();

         String responseStr = await response.stream.bytesToString();

         print(responseStr);

         Map<String, dynamic> json = jsonDecode(responseStr);

         if (response.statusCode == 200) {
           int status = json['status'];
           if (status == 200) {
             return 'success';
           }
         }
         else {
           print(response.reasonPhrase);
           return 'Error';
         }
       }

    }catch(e){
      print(e);
    }

  }

  Future<String> addReview({int id,int rating,String comment}) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json',
    };
    try {
      var body = jsonEncode({
        "order_id": id,
        "rating":rating,
        "comment":comment
      });
      var response = await http.post(Uri.parse('${_baseUrl}review'),body: body,headers: headers);

      String responseStr = response.body.toString();
      print(responseStr);

      Map<String, dynamic> json = jsonDecode(responseStr);

      if (response.statusCode == 200) {
        int status =  json['status'];
        if(status==200){
          return 'success';
        }
      }
      else {
        print(response.reasonPhrase);
        return 'Error';
      }

    }catch(e){
      print(e);
    }

  }

  Future<String> addOffer({String text,File image,int price,int offer}) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json/octet-stream',
    };
    try {
      print('${_baseUrl}category');

      final bytes1 = image.readAsBytesSync().lengthInBytes;
      final kb1 = bytes1 / 1024;
      final mb1 = kb1 / 1024;

      print(mb1.toString()+" "+mb1.toString());

     if(mb1>1){
        return "image error";
      }else {
       var request = http.MultipartRequest(
           'POST', Uri.parse('${_baseUrl}banner'))
         ..fields['text'] = text
         ..fields['price'] = price.toString()
         ..fields['offer_price'] = offer.toString()
         ..files.add(await http.MultipartFile.fromPath('image', image.path,
           contentType: MediaType('image', 'png/jpeg/jpg'),
         ));

       request.headers.addAll(headers);

       http.StreamedResponse response = await request.send();

       String responseStr = await response.stream.bytesToString();

       print(responseStr);

       Map<String, dynamic> json = jsonDecode(responseStr);

       if (response.statusCode == 200) {
         int status = json['status'];
         if (status == 200) {
           return 'success';
         }
       }
       else {
         print(response.reasonPhrase);
         return 'Error';
       }
     }
    }catch(e){
      print(e);
    }

  }

  Future<String> editOffer({int id, String text,File image,int price,int offer}) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json/octet-stream',
    };
    try {
      print('${_baseUrl}banner/$id');
      var request;


      if(image==null){
        request = http.MultipartRequest('PUT', Uri.parse('${_baseUrl}banner/$id'))
          ..fields['price'] = price.toString()
          ..fields['offer_price'] = offer.toString()
          ..fields['text'] = text;
      }else{
        request = http.MultipartRequest('PUT', Uri.parse('${_baseUrl}banner/$id'))
          ..fields['price'] = price.toString()
          ..fields['offer_price'] = offer.toString()
          ..fields['text'] = text
          ..files.add(await http.MultipartFile.fromPath('image', image.path,
            contentType:MediaType('image','png/jpeg/jpg'),
          ));
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      String responseStr = await response.stream.bytesToString();

      print(responseStr);

      Map<String, dynamic> json = jsonDecode(responseStr);

      if (response.statusCode == 200) {
        int status = json['status'];
        if (status == 200) {
          return 'success';
        }
      }
      else {
        print(response.reasonPhrase);
        return 'Error';
      }

    }catch(e){
      print(e);
    }

  }

  Future<String> editCategory({int categoryId,String name,File image}) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json/octet-stream',
    };
    try {
      print('${_baseUrl}category/$categoryId');
      var request;
      if(image==null){
        request = http.MultipartRequest('PUT', Uri.parse('${_baseUrl}category/$categoryId'))
          ..fields['name'] = name;
      }else{
        request = http.MultipartRequest('PUT', Uri.parse('${_baseUrl}category/$categoryId'))
          ..fields['name'] = name
          ..files.add(await http.MultipartFile.fromPath('image', image.path,
            contentType:MediaType('image','png/jpeg/jpg'),
          ));
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      String responseStr = await response.stream.bytesToString();

      print(responseStr);

      Map<String, dynamic> json = jsonDecode(responseStr);

      if (response.statusCode == 200) {
        int status = json['status'];
        if (status == 200) {
          return 'success';
        }
      }
      else {
       print(response.reasonPhrase);
        return 'Error';
      }

    }catch(e){
      print(e);
      print(e.hashCode);
    }

  }

  Future<String> deleteCategory({int categoryId}) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json',
    };
    try {
      var request = http.Request('DELETE', Uri.parse('${_baseUrl}category/$categoryId'));
      print(2);
      request.headers.addAll(headers);
      print(2);
      http.StreamedResponse response = await request.send();
      print(2);
      String responseStr = await response.stream.bytesToString();

      print(responseStr);

      Map<String, dynamic> json = jsonDecode(responseStr);

      if (response.statusCode == 200) {
        int status = json['status'];
        if (status == 200) {
          return 'success';
        }
      }
      else {
        print(response.reasonPhrase);
        return 'Error';
      }

    }catch(e){
      print(e);
    }

  }


  Future<String> deleteOffer({int id}) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json',
    };
    try {
      var request = http.Request('DELETE', Uri.parse('${_baseUrl}banner/$id'));
      print(2);
      request.headers.addAll(headers);
      print(2);
      http.StreamedResponse response = await request.send();
      print(2);
      String responseStr = await response.stream.bytesToString();

      print(responseStr);

      Map<String, dynamic> json = jsonDecode(responseStr);

      if (response.statusCode == 200) {
        int status = json['status'];
        if (status == 200) {
          return 'success';
        }
      }
      else {
        print(response.reasonPhrase);
        return 'Error';
      }

    }catch(e){
      print(e);
    }

  }
  Future<String> bookService(Order order) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    print(1);
    try{
      print(1);
      var headers = {
        'x-refresh-token': token,
        'Content-Type': 'application/json'
      };

      var request = http.Request('POST', Uri.parse('${_baseUrl}order'));

      request.headers.addAll(headers);

      request.body = jsonEncode({
        "date":order.date,
        "start_time":order.start_time,
        "end_time":order.end_time,
        "address":order.address,
        "service_id":order.service_id,
        "quantity":order.quantity
      });

      http.StreamedResponse response = await request.send();

      String responseStr = await response.stream.bytesToString();

      print(responseStr);

      Map<String, dynamic> json = jsonDecode(responseStr);

      if (response.statusCode == 200) {
        int status =  json['status'];
        OrderViewModel.orderId = json['data']['order']['id'];
        if(status==200){
          return 'success';
        }
      }
      else {
        print(response.reasonPhrase);
        return 'Error';
      }
    }catch(e){
      print(e);
    }
  }

  Future<List<BookingModel>> getBookings(String type) async {
    final List<BookingModel> bookings = [];
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('${_baseUrl}order?status=$type'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();
    print(responseStr);

    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status =  json['status'];
      if(status==200){
        List orders = json['data']['orders'];
          orders.forEach((element) {
            try {
              bookings.add(
                  BookingModel(
                      id: element['id'],
                      name: element['service']['name'],
                      categoryName: element['service']['category_name'],
                      address: element['address'],
                      totalPrice: element['total'],
                      startTime: element['start_time'],
                      endTime: element['end_time'],
                      status: element['status'],
                      payStatus: element['payment_status'],
                      payMethod: element['payment_method'],
                      icon: element['service']['icon'],
                      date: element['date'],
                      quantity: element['quantity']
                  )
              );
            }catch(e){

            }
          });
        return bookings;
      }
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }

  Future<List<String>> getUserDetail(int id) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token
    };
    var request = http.Request('GET', Uri.parse('${_baseUrl}user/$id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();

    Map<String, dynamic> json = jsonDecode(responseStr);

    List<String> userDetails = [];

    if (response.statusCode == 200) {
      int status =  json['status'];
      if(status==200){
        String name = json['data']['user']['name'];
        String phone = json['data']['user']['phone'];
        userDetails.add(name);
        userDetails.add(phone);
        return userDetails;
      }
    }
    else {
      print(response.reasonPhrase);
      return ["",""];
    }
  }

  Future<List<ReviewModel>> getReviews() async {
    final List<ReviewModel> reviews = [];
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('${_baseUrl}review'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();
    print(responseStr);

    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status =  json['status'];
      if(status==200){
        List orders = json['data']['reviews'];

        orders.forEach((element) {
          String date = element['created_at'].toString();
          int idx = date.indexOf("T");

          reviews.add(
              ReviewModel(
                  name: element['user']['name'],
                  date: date.substring(0,idx).trim(),
                  stars: element['rating'],
                  review: element['comment'],
                  img: element['user']['name'].toString().substring(0,1)
              )
          );
        });
        return reviews;
      }
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
  }

  Future<BookingModel> getBooking(int id) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('${_baseUrl}order/$id'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String responseStr = await response.stream.bytesToString();
    print(responseStr);

    Map<String, dynamic> json = jsonDecode(responseStr);

    if (response.statusCode == 200) {
      int status =  json['status'];
      if(status==200){
        int additionalPrice ;
        int additionalId ;
        String desc;
        try{
          additionalPrice = json['data']['order']['additional_charges'][0]['price'];
          desc = json['data']['order']['additional_charges'][0]['description'];
          additionalId = json['data']['order']['additional_charges'][0]['id'];
        }catch(e){
          additionalPrice = 0;
          additionalId = 0;
          desc = "";
        }

        List<String> userDetails = await getUserDetail(json['data']['order']['user_id']);

        return BookingModel(
            id: json['data']['order']['id'],
            name: json['data']['order']['service']['name'],
            categoryName: json['data']['order']['service']['category_name'],
            address: json['data']['order']['address'],
            totalPrice: json['data']['order']['total'],
            startTime: json['data']['order']['start_time'],
            endTime: json['data']['order']['end_time'],
            status: json['data']['order']['status'],
            payStatus: json['data']['order']['payment_status'],
            additionalPrice: additionalPrice,
            userName: userDetails[0],
            userPhone: userDetails[1],
            additionalDesc: desc,
            reviewed: json['data']['order']['reviewed'],
            additionalId: additionalId,
            payMethod: json['data']['order']['payment_method'],
            icon: json['data']['order']['service']['icon'],
            date: json['data']['order']['date'],
            quantity:json['data']['order']['quantity']
        );
      }
    }
    else {
      print(response.reasonPhrase);
      return BookingModel();
    }
  }

  Future<String> updateOrder(int id,String status) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    var headers = {
      'x-refresh-token': token,
      'Content-Type': 'application/json',
    };
    print(id);
    try {
      print('${_baseUrl}order/$id/$status');

      var request = http.Request('PUT', Uri.parse('${_baseUrl}order/$id/$status'));

      request.headers.addAll(headers);

      request.body = jsonEncode({
        "status":"success",
      });

      http.StreamedResponse response = await request.send();

      String responseStr = await response.stream.bytesToString();

      print(responseStr);

      Map<String, dynamic> json = jsonDecode(responseStr);

      if (response.statusCode == 200) {
        int status = json['status'];
        if (status == 200) {
          return 'success';
        }
      }
      else {
        print(response.reasonPhrase);
        return 'Error';
      }

    }catch(e){
      print(e);
    }

  }


  Future<String> addMessage(String message) async {
    // var url = Uri.https(_baseUrl, '/exam/get');
    // final List<ServiceModel> services = [];
    // Response response = await http.get(url);
    await Future.delayed(Duration(seconds: 5));
    return 'success';
  }

  Future<String> paymentStatus(int orderId,String paymentId,String method) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    print(1);
    try{
      print(1);
      var headers = {
        'x-refresh-token': token,
        'Content-Type': 'application/json'
      };

      print("======================$orderId======$paymentId=========$method");

      var request = http.Request('PUT', Uri.parse('${_baseUrl}order/$orderId/payment'));

      request.headers.addAll(headers);

      request.body = jsonEncode(
          {
            "status":"success",
            "transaction_id":paymentId,
            "method":method
          }
      );

      http.StreamedResponse response = await request.send();

      String responseStr = await response.stream.bytesToString();

      print(responseStr);

      Map<String, dynamic> json = jsonDecode(responseStr);

      if (response.statusCode == 200) {
        int status =  json['status'];
        if(status==200){
          return 'success';
        }
      }
      else {
        print(response.reasonPhrase);
        return 'Error';
      }
    }catch(e){
      print(e);
    }
  }

  Future<String> addAdditionalCharge(int orderId,int price,String desc) async {
    String token = await AppPreferences().getRefreshToken();
    print(token);
    print(1);
    try{
      print(1);
      var headers = {
        'x-refresh-token': token,
        'Content-Type': 'application/json'
      };

      var request = http.Request('POST', Uri.parse('${_baseUrl}additional-charge'));

      request.headers.addAll(headers);

      request.body = jsonEncode({
        "order_id": orderId,
        "price": price,
        "description": desc
      });

      http.StreamedResponse response = await request.send();

      String responseStr = await response.stream.bytesToString();

      print(responseStr);

      Map<String, dynamic> json = jsonDecode(responseStr);

      if (response.statusCode == 200) {
        int status =  json['status'];
        if(status==200){
          return 'success';
        }
      }
      else {
        print(response.reasonPhrase);
        return 'Error';
      }
    }catch(e){
      print(e);
    }
  }
}
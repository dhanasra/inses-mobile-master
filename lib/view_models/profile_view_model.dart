import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:inses_app/app/app.dart';

class ProfileViewModel {
  static ProfileViewModel _instance;
  var messageController;
  FocusNode messageFocus;
  var nameController;
  FocusNode nameFocus;
  var passwordController;
  FocusNode passwordFocus;
  var oldpasswordController;
  FocusNode oldpasswordFocus;
  var phoneController;
  FocusNode phoneFocus;

  static String name = '';
  static String phone = '';
  static String address = '';

  factory ProfileViewModel(App app) {
    _instance ??= ProfileViewModel._internal();
    return _instance;
  }

  ProfileViewModel._internal() {
    _init();
  }

  void _init() {
    nameFocus = FocusNode();
    nameController = TextEditingController(text: "");
    oldpasswordFocus = FocusNode();
    oldpasswordController = TextEditingController(text: "");
    passwordFocus = FocusNode();
    passwordController = TextEditingController(text: "");
    messageFocus = FocusNode();
    messageController = TextEditingController(text: "");
    phoneFocus = FocusNode();
    phoneController = TextEditingController(text: "");

    passwordController.addListener(() {
      String password = passwordController.text.toString();
      if (password.isNotEmpty && (password[0] == " " || password[0] == "."))
        passwordController.text = "";
    });

    oldpasswordController.addListener(() {
      String password = oldpasswordController.text.toString();
      if (password.isNotEmpty && (password[0] == " " || password[0] == "."))
        oldpasswordController.text = "";
    });

    nameController.addListener(() {
      String password = nameController.text.toString();
      if (password.isNotEmpty && (password[0] == " " || password[0] == "."))
        nameController.text = "";
    });

    messageController.addListener(() {
      String password = messageController.text.toString();
      if (password.isNotEmpty && (password[0] == " " || password[0] == "."))
        messageController.text = "";
    });

    phoneController.addListener(() {
      String password = phoneController.text.toString();
      if (password.isNotEmpty && (password[0] == " " || password[0] == "."))
        messageController.text = "";
    });
  }

}
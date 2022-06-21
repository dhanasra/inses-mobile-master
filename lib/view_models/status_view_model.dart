import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:inses_app/app/app.dart';

class StatusViewModel {
  static StatusViewModel _instance;

  factory StatusViewModel(App app) {
    _instance ??= StatusViewModel._internal();
    return _instance;
  }

  StatusViewModel._internal() {
    _init();
  }

  void _init() {

  }

}
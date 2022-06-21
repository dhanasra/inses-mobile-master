import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class AppPreferences {
  // Constants for Preference-Value's data-type
  static const String PREF_TYPE_BOOL = "BOOL";
  static const String PREF_TYPE_INTEGER = "INTEGER";
  static const String PREF_TYPE_DOUBLE = "DOUBLE";
  static const String PREF_TYPE_STRING = "STRING";

  //-------------------------------------------------------------------- Singleton ----------------------------------------------------------------------
  // Final static instance of class initialized by private constructor
  static final AppPreferences _instance = AppPreferences._internal();
  // Factory Constructor
  factory AppPreferences() => _instance;

  AppPreferences._internal();

  //User Info

  Future<void> setName({@required String firstName}) => setPreference(
      prefName: AppConstants.NAME,
      prefType: PREF_TYPE_STRING,
      prefValue: firstName);
  Future<void> setPhoneNumber({@required String phone}) => setPreference(
      prefName: AppConstants.PHONE_NUMBER,
      prefType: PREF_TYPE_STRING,
      prefValue: phone);
  Future<void> setLoginStatus({@required String status}) => setPreference(
      prefName: AppConstants.LOGIN_STATUS,
      prefType: PREF_TYPE_STRING,
      prefValue: status);
  Future<void> setToken({@required String token}) => setPreference(
      prefName: AppConstants.TOKEN,
      prefType: PREF_TYPE_STRING,
      prefValue: token);
  Future<void> setRefreshToken({@required String refreshToken}) => setPreference(
      prefName: AppConstants.R_TOKEN,
      prefType: PREF_TYPE_STRING,
      prefValue: refreshToken);

  Future<dynamic> getName() async =>
      await _getPreference(prefName: AppConstants.NAME) ?? "";
  Future<dynamic> getPhoneNumber() async =>
      await _getPreference(prefName: AppConstants.PHONE_NUMBER) ??
      "";
  Future<dynamic> getLoginStatus() async =>
      await _getPreference(prefName: AppConstants.LOGIN_STATUS) ??
      AppConstants.LOGGED_OUT;
  Future<dynamic> getToken() async =>
      await _getPreference(prefName: AppConstants.TOKEN) ??
          "";
  Future<dynamic> getRefreshToken() async =>
      await _getPreference(prefName: AppConstants.R_TOKEN) ??
          "";

 Future<void> setPreference(
      {@required String prefName,
      @required dynamic prefValue,
      @required String prefType}) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    switch (prefType) {
      // prefType is bool
      case PREF_TYPE_BOOL:
        {
          _preferences.setBool(prefName, prefValue);
          break;
        }
      // prefType is int
      case PREF_TYPE_INTEGER:
        {
          _preferences.setInt(prefName, prefValue);
          break;
        }
      // prefType is double
      case PREF_TYPE_DOUBLE:
        {
          _preferences.setDouble(prefName, prefValue);
          break;
        }
      // prefType is String
      case PREF_TYPE_STRING:
        {
          _preferences.setString(prefName, prefValue);
          break;
        }
    }
  }

  Future<dynamic> _getPreference({@required prefName}) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.get(prefName);
  }
}

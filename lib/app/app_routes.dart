
import 'package:flutter/cupertino.dart';
import 'package:inses_app/views/about.dart';
import 'package:inses_app/views/add_additional_charge.dart';
import 'package:inses_app/views/add_category.dart';
import 'package:inses_app/views/add_offer.dart';
import 'package:inses_app/views/add_review.dart';
import 'package:inses_app/views/add_service.dart';
import 'package:inses_app/views/address_select.dart';
import 'package:inses_app/views/booking_desc.dart';
import 'package:inses_app/views/bookings.dart';
import 'package:inses_app/views/contact.dart';
import 'package:inses_app/views/date_time_select.dart';
import 'package:inses_app/views/ed_category.dart';
import 'package:inses_app/views/ed_offer.dart';
import 'package:inses_app/views/ed_service.dart';
import 'package:inses_app/views/home_main.dart';
import 'package:inses_app/views/items.dart';
import 'package:inses_app/views/launch.dart';
import 'package:inses_app/views/login.dart';
import 'package:inses_app/views/name_fields.dart';
import 'package:inses_app/views/no_internet.dart';
import 'package:inses_app/views/password_settings.dart';
import 'package:inses_app/views/payment_history.dart';
import 'package:inses_app/views/profile.dart';
import 'package:inses_app/views/register.dart';
import 'package:inses_app/views/select_category.dart';
import 'package:inses_app/views/service_add_cart.dart';
import 'package:inses_app/views/service_select.dart';
import 'package:inses_app/views/service_summary.dart';
import 'package:inses_app/views/settings.dart';
import 'package:inses_app/views/update_booking_status.dart';

class AppRoutes {
  //Authentication pages
  static const String APP_SPLASH = '/splash';
  static const String APP_NAME_FIELDS = '/name_fields';
  static const String APP_REGISTER = '/register';
  static const String APP_FORGOT_PASSWORD = '/forgot_password';
  static const String APP_LOGIN = '/login';
  static const String APP_AUTH_LOAD = '/auth_load';
  static const String APP_SPLASH_LOAD = '/splash_load';
  static const String APP_LAUNCH = '/launch';


  static const String APP_HOME_MAIN = '/home_main';

  static const String APP_BOOKING = '/booking';

  static const String APP_BOOKING_INFO = '/booking_info';

  static const String APP_PROFILE = '/profile';
  static const String APP_SETTINGS = '/settings';
  static const String APP_PASSWORD_SETTINGS = '/password_settings';
  static const String APP_CONTACT = '/contact';
  static const String APP_ABOUT = '/about';
  static const String APP_PAYMENT_HISTORY = '/payment_history';

  static const String APP_ORDER_FLOW_1 = '/order_flow_1';
  static const String APP_ORDER_FLOW_2 = '/order_flow_2';
  static const String APP_ORDER_FLOW_3 = '/order_flow_3';
  static const String APP_ORDER_FLOW_4 = '/order_flow_4';
  static const String APP_ORDER_FLOW_5 = '/order_flow_5';

  static const String APP_ADD_REVIEW = '/add_review';

  static const String APP_NO_INTERNET = '/no_internet';

  // admin

  static const String APP_SERVICE_LIST = '/service_list';
  static const String APP_SELECT_CATEGORY = '/select_category';

  static const String APP_ADD_SERVICE = '/add_service';
  static const String APP_ADD_CATEGORY = '/add_category';
  static const String APP_ADD_OFFER = '/add_offer';

  static const String APP_ED_SERVICE = '/ed_service';
  static const String APP_ED_CATEGORY = '/ed_category';
  static const String APP_ED_OFFER = '/ed_offer';

  static const String APP_ADDITIONAL_CHARGE = '/additional_charge';

  static const String APP_UPDATE_BOOKING_STATUS = '/update_booking_status';

  Route getRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case APP_NO_INTERNET:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => NoInternet(),
            fullscreenDialog: true,
          );
        }
      case APP_SELECT_CATEGORY:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => SelectCategory(),
            fullscreenDialog: true,
          );
        }
      case APP_ADD_REVIEW:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => AddReview(),
            fullscreenDialog: true,
          );
        }
      case APP_ADDITIONAL_CHARGE:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => AddAdditionalCharge(),
            fullscreenDialog: true,
          );
        }
      case APP_LAUNCH:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => Launch(),
            fullscreenDialog: true,
          );
        }
      case APP_UPDATE_BOOKING_STATUS:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => UpdateBookingStatus(),
            fullscreenDialog: true,
          );
        }
      case APP_SERVICE_LIST:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => Items(),
            fullscreenDialog: true,
          );
        }
      case APP_ADD_CATEGORY:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => AddCategory(),
            fullscreenDialog: true,
          );
        }
      case APP_ADD_OFFER:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => AddOffer(),
            fullscreenDialog: true,
          );
        }
      case APP_ADD_SERVICE:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => AddService(),
            fullscreenDialog: true,
          );
        }
      case APP_ED_CATEGORY:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => EdCategory(),
            fullscreenDialog: true,
          );
        }
      case APP_ED_OFFER:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => EdOffer(),
            fullscreenDialog: true,
          );
        }
      case APP_ED_SERVICE:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => EdService(),
            fullscreenDialog: true,
          );
        }
      case APP_PAYMENT_HISTORY:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => PaymentHistory(),
            fullscreenDialog: true,
          );
        }
      case APP_CONTACT:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => Contact(),
            fullscreenDialog: true,
          );
        }
      case APP_ABOUT:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => About(),
            fullscreenDialog: true,
          );
        }
      case APP_PASSWORD_SETTINGS:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => PasswordSettings(),
            fullscreenDialog: true,
          );
        }
      case APP_SETTINGS:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => Settings(),
            fullscreenDialog: true,
          );
        }
      case APP_PROFILE:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => Profile(),
            fullscreenDialog: true,
          );
        }
      case APP_BOOKING_INFO:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => BookingDesc(),
            fullscreenDialog: true,
          );
        }
      case APP_BOOKING:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => Bookings(),
            fullscreenDialog: true,
          );
        }
      case APP_HOME_MAIN:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => HomeMain(),
            fullscreenDialog: true,
          );
        }
      case APP_ORDER_FLOW_1:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => ServiceSelect(),
            fullscreenDialog: true,
          );
        }
      case APP_ORDER_FLOW_2:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => ServiceAddCart(),
            fullscreenDialog: true,
          );
        }
      case APP_ORDER_FLOW_3:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => AddressSelect(),
            fullscreenDialog: true,
          );
        }
      case APP_ORDER_FLOW_4:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => DateTimeSelect(),
            fullscreenDialog: true,
          );
        }
      case APP_ORDER_FLOW_5:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => ServiceSummary(),
            fullscreenDialog: true,
          );
        }
      case APP_LOGIN:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => Login(),
            fullscreenDialog: true,
          );
        }
      case APP_REGISTER:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => Register(),
            fullscreenDialog: true,
          );
        }
      case APP_NAME_FIELDS:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => NameFields(),
            fullscreenDialog: true,
          );
        }
      case APP_HOME_MAIN:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => HomeMain(),
            fullscreenDialog: true,
          );
        }
      default:
        {
          return CupertinoPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => Container(),
            fullscreenDialog: true,
          );
        }
    }
  }

  getWidget(BuildContext context, String appRouteName) {
    switch (appRouteName) {
      case APP_NO_INTERNET:
        {
          return NoInternet();
        }
      case APP_SELECT_CATEGORY:
        {
          return SelectCategory();
        }
      case APP_ADD_REVIEW:
        {
          return AddReview();
        }
      case APP_ADDITIONAL_CHARGE:
        {
          return AddAdditionalCharge();
        }
      case APP_LAUNCH:
        {
          return Launch();
        }
      case APP_UPDATE_BOOKING_STATUS:
        {
          return UpdateBookingStatus();
        }
      case APP_SERVICE_LIST:
        {
          return Items();
        }
      case APP_ADD_CATEGORY:
        {
          return AddCategory();
        }
      case APP_ADD_OFFER:
        {
          return AddOffer();
        }
      case APP_ADD_SERVICE:
        {
          return AddService();
        }
      case APP_ED_CATEGORY:
        {
          return EdCategory();
        }
      case APP_ED_OFFER:
        {
          return EdOffer();
        }
      case APP_ED_SERVICE:
        {
          return EdService();
        }
      case APP_PAYMENT_HISTORY:
        {
          return PaymentHistory();
        }
      case APP_CONTACT:
        {
          return Contact();
        }
      case APP_ABOUT:
        {
          return About();
        }
      case APP_SETTINGS:
        {
          return Settings();
        }
      case APP_PASSWORD_SETTINGS:
        {
          return PasswordSettings();
        }
      case APP_PROFILE:
        {
          return Profile();
        }
      case APP_BOOKING_INFO:
        {
          return BookingDesc();
        }
      case APP_BOOKING:
        {
          return Bookings();
        }
      case APP_ORDER_FLOW_1:
        {
          return ServiceSelect();
        }
      case APP_ORDER_FLOW_2:
        {
          return ServiceAddCart();
        }
      case APP_ORDER_FLOW_3:
        {
          return AddressSelect();
        }
      case APP_ORDER_FLOW_4:
        {
          return DateTimeSelect();
        }
      case APP_ORDER_FLOW_5:
        {
          return ServiceSummary();
        }
      case APP_LOGIN:
        {
          return Login();
        }
      case APP_REGISTER:
        {
          return Register();
        }
      case APP_NAME_FIELDS:
        {
          return NameFields();
        }
      case APP_HOME_MAIN:
        {
          return HomeMain();
        }
      default:
        {
          return Container();
        }
    }
  }
}

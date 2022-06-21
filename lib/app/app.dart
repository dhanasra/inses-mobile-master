import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/line.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/database/constants.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/resources/app_style.dart';
import 'package:inses_app/views/address_select.dart';
import 'package:inses_app/views/booking_desc.dart';
import 'package:inses_app/views/date_time_select.dart';
import 'package:inses_app/views/home_main.dart';
import 'package:inses_app/views/payment_choose.dart';
import 'package:inses_app/views/service_add_cart.dart';
import 'package:inses_app/views/service_select.dart';
import 'package:inses_app/views/service_summary.dart';
import 'package:inses_app/views/splash.dart';
import 'package:line_icons/line_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app_localizations.dart';
import 'app_routes.dart';

class App extends StatelessWidget {
  static final App _instance = App._internal();

  App._internal();
  factory App() {
    return _instance;
  }

  @override
  Widget build(BuildContext context) {
      return getMaterialApp(widget: Splash(), title: 'Launch', buildContext: context);

  }

  AppRoutes getAppRoutes() {
    return AppRoutes();
  }

  Widget getMaterialApp(
      {@required Widget widget, String title, BuildContext buildContext}) {

      return MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        home: widget,
        theme: AppStyle.lightTheme(buildContext),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          AppLocalizations.delegate
        ],
        locale: Locale('en', 'US'),
        onGenerateRoute: getAppRoutes().getRoutes,
      );
    }

  Future<dynamic> setNavigation(
      BuildContext context, String appRouteName) async {
    if(AppConstants.INTERNET=='OK'){
      Future.delayed(const Duration(milliseconds: 100), () async {
        final info = await Navigator.push(
            context,
            PageTransition(
                child: getAppRoutes().getWidget(context, appRouteName),
                type: PageTransitionType.fade,
                settings: RouteSettings(name: appRouteName),
                duration: Duration(milliseconds: 0)));

        return info;
      });
    }else{
      Future.delayed(const Duration(milliseconds: 100), () async {
        final info = await Navigator.push(
            context,
            PageTransition(
                child: getAppRoutes().getWidget(context, AppRoutes.APP_NO_INTERNET),
                type: PageTransitionType.fade,
                settings: RouteSettings(name: AppRoutes.APP_NO_INTERNET),
                duration: Duration(milliseconds: 0)));

        return info;
      });
    }
  }

  Future<bool> locationPermission() async{
    var status = await Permission.location.status;
    if (status.isDenied) {
      if (await Permission.location.request().isGranted) {
        return true;
      }else{
        if (await Permission.location.isPermanentlyDenied) {
          openAppSettings();
        }
        return false;
      }
    }else{
      return true;
    }
  }

  Future<bool> isNetworkConnectivityOn()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  Color randColor(int val) {
    switch (val) {
      case 0:
        return AppColors.TAMIL;
        break;
      case 1:
        return AppColors.ENGLISH;
        break;
      case 2:
        return AppColors.MATHS;
        break;
      case 3:
        return AppColors.PHYSICS;
        break;
      case 4:
        return AppColors.CHEMISTRY;
        break;
      case 5:
        return AppColors.BOTONY;
        break;
      case 6:
        return AppColors.BOTONY;
        break;
      case 7:
        return AppColors.ZOOLOGY;
        break;
      case 8:
        return AppColors.SCIENCE;
        break;
      case 9:
        return AppColors.GEOGRAPHY;
        break;
      case 10:
        return AppColors.PHYSICS;
        break;
      default:
        return AppColors.GK;
    }
  }


  Color subColor(String subject) {
    switch (subject) {
      case 'Tamil':
        return AppColors.TAMIL;
        break;
      case 'English':
        return AppColors.ENGLISH;
        break;
      case 'Maths':
        return AppColors.MATHS;
        break;
      case 'Physics':
        return AppColors.PHYSICS;
        break;
      case 'Chemistry':
        return AppColors.CHEMISTRY;
        break;
      case 'Biology':
        return AppColors.BOTONY;
        break;
      case 'Botony':
        return AppColors.BOTONY;
        break;
      case 'Zoology':
        return AppColors.ZOOLOGY;
        break;
      case 'Science':
        return AppColors.SCIENCE;
        break;
      case 'Geography':
        return AppColors.GEOGRAPHY;
        break;
      case 'Polytics':
        return AppColors.PHYSICS;
        break;
      case 'GK':
        return AppColors.GK;
        break;
      default:
        return AppColors.GK;
    }
  }

  PreferredSizeWidget appBarBack(BuildContext context,String title,{Widget child,VoidCallback onPressed}){
    return PreferredSize(
      preferredSize: Size.fromHeight(55),
      child: Container(
        color: AppColors.WHITE,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: OnTapField(
                      onTap: onPressed??(){App().setBackNavigation(context);},
                      child: Icon(LineIcons.arrowLeft,color: AppColors.BLACK_3,),
                    )
                  ),
                  Expanded(
                      child: Content(
                        alignment: Alignment.centerLeft,
                        text: title,
                        fontfamily: AppFont.FONT,
                        color: AppColors.BLACK_2,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_MEDIUM_3,
                      )
                  ),
                  child??Container()
                ],
              ),
            ),
            Line(width:double.infinity, height: 3,color: AppColors.WHITE_1,),
          ],
        ),
      ),
    );
  }

  String welcomeText(){
    DateTime now = DateTime.now();

    int timeOfDay = now.hour;

    if(timeOfDay >= 0 && timeOfDay < 12){
      return "Good Morning";
    }else if(timeOfDay >= 12 && timeOfDay < 16){
      return "Good Afternoon";
    }else if(timeOfDay >= 16 && timeOfDay < 21){
      return "Good Evening";
    }else if(timeOfDay >= 21 && timeOfDay < 24){
      return "Good Night";
    }else{
      return '';
    }
  }

  SnackBar snackbar(String text){
    return SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.WHITE,
        content: BorderContainer(
          radius: 20,
          child: Content(
            text: text,
            height: 30,
            fontSize: AppDimen.TEXT_SMALL,
            fontWeight: FontWeight.w500,
            fontfamily: AppFont.FONT,
            color: AppColors.INFO_COLOR,
          ),
        )
    );
  }

  String subImage(String subject){
    switch (subject) {
      case 'Tamil':
        return 'ta.png';
        break;
      case 'English':
        return 'english.png';
        break;
      case 'Maths':
        return 'maths.png';
        break;
      case 'Physics':
        return 'physics.png';
        break;
      case 'Chemistry':
        return 'chemistry.png';
        break;
      case 'Biology':
        return 'botony.png';
        break;
      case 'Botony':
        return 'botony.png';
        break;
      case 'Zoology':
        return 'zoology.png';
        break;
      case 'Science':
        return 'science.png';
        break;
      case 'Geography':
        return 'geography.png';
        break;
      case 'Polytics':
        return 'polytics.png';
        break;
      case 'GK':
        return 'knowledge.png';
        break;
      default:
        return 'knowledge.png';
    }
  }



  void setBackNavigation(BuildContext context) {
    Navigator.pop(context, "inefr");
  }

  void closeApp() {
    if (Platform.isAndroid)
      SystemNavigator.pop();
    else
      exit(0);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:line_icons/line_icons.dart';

import '../main.dart';

class NoInternet extends StatefulWidget {

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      body: buildView(),
    ), onWillPop: ()async{
    });
  }

  Widget buildView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Content(
          color:AppColors.BLACK,
          margin: EdgeInsets.only(top: 5,left: 50,right: 50,bottom: 20),
          text: 'No Internet Found',
          overflow: TextOverflow.ellipsis,
          fontfamily: AppFont.FONT,
          fontWeight: FontWeight.w500,
          fontSize: AppDimen.TEXT_SMALLER,
          alignment: Alignment.center,
          textHeight: 1.5,
        ),
        Icon(Icons.network_check_rounded,color: AppColors.WARNING_COLOR,size: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OnTapField(
                child: BorderContainer(
                  margin: EdgeInsets.all(20),
                  bgColor: AppColors.SECONDARY_COLOR,
                  padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                  radius: 2,
                  child: Content(
                    color:AppColors.WHITE,
                    text: 'Retry',
                    fontfamily: AppFont.FONT,
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimen.TEXT_SMALL,
                  ),
                ),
                onTap:(){
                  RestartWidget.restartApp(context);
                }
            )
          ],
        )
      ],
    );
  }
}

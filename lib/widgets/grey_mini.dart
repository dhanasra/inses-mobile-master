import 'package:flutter/cupertino.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class GreyMini extends StatelessWidget {
  final String text;
  GreyMini({this.text});
  @override
  Widget build(BuildContext context) {
    return Content(
      margin: EdgeInsets.only(top: 15,bottom: 10,left: 20,right: 20),
      text: text,
      textHeight: 1.5,
      textAlign: TextAlign.center,
      alignment: Alignment.center,
      color: AppColors.GRAY,
      fontfamily: AppFont.FONT,
      letterSpacing: 1.2,
      fontSize: AppDimen.TEXT_SMALL,
      fontWeight: FontWeight.w500,
    );
  }
}
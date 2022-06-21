import 'package:flutter/cupertino.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/database/constants.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class Sub extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry margin;
  Sub({this.text,this.margin});
  @override
  Widget build(BuildContext context) {
    return Content(
      margin: margin??EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
      text: text,
      alignment: Alignment.centerLeft,
      textAlign: TextAlign.start,
      textHeight: 1.5,
      color: AppColors.BLACK,
      fontfamily: AppFont.FONT,
      letterSpacing: 0.5,
      fontSize: AppDimen.TEXT_H7,
      fontWeight: FontWeight.w500,
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class GreyMicro extends StatelessWidget {
  final String text;
  final AlignmentGeometry alignment;
  final TextAlign align;
  GreyMicro({
    this.text,
    this.alignment,
    this.align
  });
  @override
  Widget build(BuildContext context) {
    return Content(
      margin: EdgeInsets.only(top: 5,bottom: 5,left: 20,right: 20),
      text: text,
      textHeight: 1.4,
      textAlign: align??TextAlign.left,
      alignment: alignment??Alignment.centerLeft,
      color: AppColors.GRAY_3,
      fontfamily: AppFont.FONT,
      letterSpacing: 1.2,
      fontSize: AppDimen.TEXT_SMALLEST,
      fontWeight: FontWeight.w500,
    );
  }
}
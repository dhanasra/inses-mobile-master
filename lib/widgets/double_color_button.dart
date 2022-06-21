import 'package:flutter/material.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class DoubleColorButton extends StatelessWidget {
  final String text1;
  final String text2;
  final double width;
  final double height;
  final Color bgColor;
  final Color borderColor;
  final Color txtColor;
  final double fontSize;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;
  final FontWeight fontWeight;
  final bool isShadow;
  final String fontfamily;
  final bool isLoadButton;
  final double radius;
  final VoidCallback onPressed;
  DoubleColorButton({this.text1,this.text2,
  @required this.width,
    this.height,
    this.bgColor,
    this.borderColor,
    this.txtColor,
    this.fontSize,
    this.margin,
    this.padding,
    this.isLoadButton,
    this.alignment,
    this.fontWeight,
    this.isShadow,
    this.fontfamily,
    this.radius,
    @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width:  width,
        height:  height,
        margin:  margin,
        alignment:  alignment,
        padding:  padding,
        child: FractionallySizedBox(
          widthFactor: 1,
          child: TextButton(
            child:
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Content(
                  text: text1,
                  fontSize: AppDimen.TEXT_SMALL,
                  fontWeight: FontWeight.w400,
                  fontfamily: AppFont.FONT,
                  color: AppColors.BLACK,
                ),
                Content(
                  text: text2,
                  fontSize: AppDimen.TEXT_SMALL,
                  fontWeight: FontWeight.w500,
                  fontfamily: AppFont.FONT,
                  color: AppColors.SECONDARY_COLOR,
                ),
              ],
            ), style: ButtonStyle(),
          onPressed:  onPressed,
        )),
    decoration: BoxDecoration(
        borderRadius:
          BorderRadius.circular( radius != null ?  radius : 2),
          color:  bgColor != null ?  bgColor : Colors.transparent,
          border: Border.all(
          color:  borderColor != null
          ?  borderColor
              : Colors.transparent),
          boxShadow: [
          BoxShadow(
          offset: Offset(0, 2),
          blurRadius: 10,
          color:  isShadow != null &&  isShadow
              ? Color(0x19000000)
                  : Colors.transparent,
        ),
    ],
    ));
  }
}

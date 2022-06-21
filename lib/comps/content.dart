import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/resources/app_style.dart';

class Content extends StatelessWidget {
  final String text;
  final Color color;
  final Color bgColor;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontfamily;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;
  final double width;
  final double letterSpacing;
  final double textHeight;
  final int maxline;
  final TextDecoration decoration;
  final TextOverflow overflow;
  final double height;
  final TextAlign textAlign;
  Content(
      {@required this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
        this.decoration,
      this.bgColor, this.overflow,
      this.margin,
      this.padding,
      this.textAlign,
      this.textHeight,
      this.letterSpacing,
      this.alignment,
      this.fontfamily,
      this.width,
        this.maxline,
      this.height});
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: AppStyle.lightTheme(context),
        child: Container(
          width: width,
          height: height,
          margin: margin,
          padding: padding,
          color: bgColor,
          alignment: alignment != null ? alignment : Alignment.center,
          child: Text(
            text,
            textAlign: textAlign,
            maxLines:maxline ,
            overflow: overflow?? null,
            style: TextStyle(

                height: textHeight ?? 1,
                letterSpacing: letterSpacing,
                fontFamily: fontfamily,
                fontSize: fontSize,
                decoration: decoration??TextDecoration.none,
                fontWeight: fontWeight,
                color: color),
          ),
        ));
  }
}

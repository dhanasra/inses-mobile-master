import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElevatedIconButton extends StatelessWidget {

  final String text;
  final Color color;
  final Color bgColor;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontfamily;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Icon iconData;

  ElevatedIconButton({
    this.iconData,
    this.margin,
    this.padding,
    this.onPressed,
    this.text,
    this.fontSize,
    this.fontWeight,
    this.fontfamily,
    this.bgColor,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: iconData,

          label: Padding(
              padding: padding??EdgeInsets.all(15.0),
              child: Text(text,style: TextStyle(
                fontWeight: fontWeight,
                fontFamily: fontfamily,
                fontSize: fontSize,
                color: color
              ),)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(bgColor)
          )
      ));

  }
}

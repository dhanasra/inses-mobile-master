import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
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

  PrimaryButton(
      {@required this.text,
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
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        alignment: widget.alignment,
        padding: widget.padding,
        child: FractionallySizedBox(
            widthFactor: 1,
            child: TextButton(

              child: Text(
                      widget.text,
                  style: TextStyle(
                      fontFamily: widget.fontfamily,
                      fontSize: widget.fontSize,
                      fontWeight: widget.fontWeight,
                      color: widget.txtColor)),
              style: ButtonStyle(),
              onPressed: widget.onPressed,
            )),
        decoration: BoxDecoration(

          borderRadius:
              BorderRadius.circular(widget.radius != null ? widget.radius : 2),
          color: widget.bgColor != null ? widget.bgColor : Colors.transparent,
          border: Border.all(
              color: widget.borderColor != null
                  ? widget.borderColor
                  : Colors.transparent),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 10,
              color: widget.isShadow != null && widget.isShadow
                  ? Color(0x19000000)
                  : Colors.transparent,
            ),
          ],
        ));
  }
}

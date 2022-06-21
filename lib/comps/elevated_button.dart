import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryElevatedButton extends StatefulWidget {
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

  PrimaryElevatedButton(
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
  _PrimaryElevatedButtonState createState() => _PrimaryElevatedButtonState();
}

class _PrimaryElevatedButtonState extends State<PrimaryElevatedButton> {
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
          child: ElevatedButton(
            child: Container(
              child: Text(
                      widget.text,
                  style: TextStyle(
                      fontFamily: widget.fontfamily,
                      fontSize: widget.fontSize,
                      fontWeight: widget.fontWeight,
                      color: widget.txtColor)),
            ),
            style: ElevatedButton.styleFrom(
              primary: widget.bgColor,
              onPrimary: widget.txtColor,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(widget.radius),
              ),
            ),
            onPressed: widget.onPressed,
          ),
        )
        );
  }
}

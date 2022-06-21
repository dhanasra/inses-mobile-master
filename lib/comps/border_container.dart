import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final Color borderColor;
  final double radius;
  final bool isShadow;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  BorderContainer(
      {this.child,
      this.bgColor,
      this.borderColor,
      this.radius,
      this.isShadow,
      this.margin,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
            child: child,
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius != null ? radius : 2),
              color: bgColor != null
                  ? bgColor
                  : isShadow != null && isShadow
                      ? Colors.white
                      : Colors.transparent,
              border: Border.all(
                  color:
                      borderColor != null ? borderColor : Colors.transparent),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 10,
                  color: isShadow != null && isShadow
                      ? Color(0x19000000)
                      : Colors.transparent,
                ),
              ],
            ))
      ],
    );
  }
}

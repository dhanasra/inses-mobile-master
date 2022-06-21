import 'package:flutter/cupertino.dart';

class Line extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Color bgColor;

  final EdgeInsetsGeometry margin;

  Line({
    @required this.width,
    @required this.height,
    this.color,
    this.bgColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: bgColor,
        child: Container(
          width: width,
          margin: margin,
          height: height,
          color: color != null ? color : Color(0xFF777777),
        ));
  }
}

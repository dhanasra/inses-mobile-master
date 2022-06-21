import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/resources/app_colors.dart';

class Loader extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  Loader({this.margin});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:margin?? EdgeInsets.all(50),
      child: Transform.scale(
        scale: 0.7,
        child: CircularProgressIndicator(
          valueColor:  AlwaysStoppedAnimation<Color>(AppColors.INFO_COLOR),
        ),
      )
    );
  }
}

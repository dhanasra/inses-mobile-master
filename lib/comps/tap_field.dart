import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inses_app/resources/app_colors.dart';

class OnTapField extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  OnTapField({@required this.child, @required this.onTap});
  @override
  _TextOnTapState createState() => _TextOnTapState();
}

class _TextOnTapState extends State<OnTapField> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: widget.child,
          splashColor: AppColors.WHITE_2,
          highlightColor: AppColors.WHITE_2,
          onTap: widget.onTap,
        );
  }
}

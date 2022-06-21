import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/image_view.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'grey_mini.dart';

class LaunchSliderItem extends StatelessWidget {
  final String text;
  final String subText;
  final String image;
  LaunchSliderItem({this.text,this.subText,this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      child: Column(
        children: [
          Content(
            margin: EdgeInsets.only(top: 70),
            text: text,
            textAlign: TextAlign.center,
            alignment: Alignment.center,
            textHeight: 1.3,
            padding: EdgeInsets.only(left: 50,right: 50),
            fontSize: AppDimen.TEXT_H1_GIANT,
            fontWeight: FontWeight.w900,
            fontfamily: AppFont.FONT,
            color: AppColors.BLACK,
          ),
          ImageView(width: 260,asset: image,),
          GreyMini(text: subText,),
        ],
      ),
    );
  }
}

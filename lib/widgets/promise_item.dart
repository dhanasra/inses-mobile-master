import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class PromiseItem extends StatelessWidget {

  final Icon img;
  final String text1;
  final String text2;

  PromiseItem({this.img,this.text2,this.text1});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            child: img,
          ),
          Content(
            padding: EdgeInsets.only(left: 20,top: 10,right: 20),
            alignment: Alignment.centerLeft,
            text:text1,
            fontfamily: AppFont.FONT,
            color: AppColors.BLACK,
            fontWeight: FontWeight.w500,
            fontSize: AppDimen.TEXT_MEDIUM_3,
          ),
          Content(
            padding: EdgeInsets.only(left: 20,top: 10,right: 20),
            alignment: Alignment.centerLeft,
            text: text2,
            maxline: 3,
            textHeight: 1.5,
            fontfamily: AppFont.FONT,
            color: AppColors.GRAY,
            fontWeight: FontWeight.w400,
            fontSize: AppDimen.TEXT_SMALLEST,
          )
        ],
      ),
    );
  }
}

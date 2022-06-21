import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class MiniCardItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children:[ Card(
          margin: EdgeInsets.only(left: 10,right: 10),
          elevation: 4,
          child: Container(
            width: 300,
            height: 80,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BorderContainer(
                  margin: EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
                  child: Content(
                    margin: EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
                    text: '1',
                    alignment: Alignment.centerLeft,
                    textAlign: TextAlign.start,
                    textHeight: 1.5,
                    color: AppColors.SECONDARY_COLOR,
                    fontfamily: AppFont.FONT,
                    letterSpacing: 0.5,
                    fontSize: AppDimen.TEXT_SMALLEST,
                    fontWeight: FontWeight.w500,
                  ),
                  radius: 4,
                  bgColor: AppColors.WHITE_1,
                ),
                Flexible(
                    child:Content(
                      width: 320,
                      margin: EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
                      text: 'Use of Top Quality Specialised and Safe Chemicals',
                      alignment: Alignment.centerLeft,
                      textAlign: TextAlign.start,
                      textHeight: 1.5,
                      maxline: 2,
                      color: AppColors.BLACK,
                      fontfamily: AppFont.FONT,
                      letterSpacing: 0.5,
                      fontSize: AppDimen.TEXT_SMALLEST,
                      fontWeight: FontWeight.w500,
                    )
                )
              ],
            ),
          ),
        )]
    );
  }
}

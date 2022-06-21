import 'package:flutter/cupertino.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/line.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class Or extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   Container(
        margin: EdgeInsets.only(top: 50, bottom: 20,left: 20,right: 20),
        width: 400,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Line(
                    height: 1,
                    color: AppColors.WHITE_3,
                    width: double.infinity,
                  )),
              Content(
                margin:
                EdgeInsets.only(left: 10, right: 10),
                text: 'OR',
                alignment: Alignment.center,
                padding: EdgeInsets.only(),
                color: AppColors.GRAY_3,
                fontSize: AppDimen.TEXT_MEDIUM_1,
                fontfamily: AppFont.FONT,
              ),
              Expanded(
                  child: Line(
                    height: 1,
                    color: AppColors.WHITE_3,
                    width: double.infinity,
                  ))
            ]));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class DateItem extends StatelessWidget {
  final String date;
  final String day;
  final bool isSelected;

  DateItem({this.date,this.day,this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      child: BorderContainer(
        borderColor: isSelected?AppColors.SECONDARY_COLOR:AppColors.WHITE_1,
        radius: 5,
        padding: EdgeInsets.all(20),
        bgColor: isSelected?AppColors.WHITE:AppColors.WHITE_1,
        child: Container(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              date=='pick'
                  ?Icon(Icons.date_range,)
                  :Content(
                alignment: Alignment.center,
                text: date,
                fontfamily: AppFont.FONT,
                color: AppColors.SECONDARY_COLOR,
                fontWeight: FontWeight.w500,
                fontSize: AppDimen.TEXT_H1_LARGE,
              ),
              Content(
                padding: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                text: day,
                fontfamily: AppFont.FONT,
                color: AppColors.BLACK,
                fontWeight: FontWeight.w500,
                fontSize: AppDimen.TEXT_SMALLEST,
              )
            ],
          ),
        ),
        )
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class TimeItem extends StatelessWidget {

  final String time;
  final bool isSelected;

  TimeItem({this.isSelected,this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      child: BorderContainer(
        borderColor: isSelected?AppColors.SECONDARY_COLOR:AppColors.WHITE_1,
        radius: 5,
        padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
        bgColor: isSelected?AppColors.WHITE:AppColors.WHITE_1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Content(
              alignment: Alignment.center,
              text: time,
              fontfamily: AppFont.FONT,
              color: AppColors.BLACK,
              fontWeight: FontWeight.w500,
              fontSize: AppDimen.TEXT_SMALLEST,
            )
          ],
        ),
      ),
    );
  }
}

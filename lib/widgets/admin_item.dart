import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class AdminItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onPressed;

  AdminItem({this.name,this.icon,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OnTapField(
        child: Container(
          child: BorderContainer(
            radius: 5,
            borderColor: AppColors.WHITE_1,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(icon,color: AppColors.PRIMARY_COLOR,)
                  ],
                ),
                Content(
                  padding: EdgeInsets.only(top: 8,bottom: 8),
                  alignment: Alignment.center,
                  text: name,
                  color: AppColors.BLACK_3,
                  fontfamily: AppFont.FONT,
                  fontSize: AppDimen.TEXT_SMALL,
                  fontWeight: FontWeight.w600,
                ),
                Content(
                  padding: EdgeInsets.only(top: 8,bottom: 15),
                  alignment: Alignment.center,
                  text: 'Add / Edit $name',
                  color: AppColors.GRAY,
                  fontfamily: AppFont.FONT,
                  fontSize: AppDimen.TEXT_SMALLEST,
                  fontWeight: FontWeight.w600,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_forward,color: AppColors.GRAY,)
                  ],
                )
              ],
            ),
          ),
        ),
        onTap: onPressed
    );
  }
}

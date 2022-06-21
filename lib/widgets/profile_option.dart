import 'package:flutter/cupertino.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:line_icons/line_icons.dart';

class ProfileOption extends StatelessWidget {

  final String option;
  final String sub;
  final IconData icon;
  final Icon trailingIcon;
  final VoidCallback onPressed;

  ProfileOption({this.onPressed,this.icon,this.option,this.sub,this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return OnTapField(
        child: _build(),
        onTap: onPressed
    );
  }

  Widget _build(){
    return Container(
      padding: EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(icon,color: AppColors.BLACK_3,),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Content(
                    alignment: Alignment.centerLeft,
                    text: option,
                    fontfamily: AppFont.FONT,
                    color: AppColors.BLACK_1,
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimen.TEXT_SMALL,
                  ),
                  Content(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    text: sub,
                    fontfamily: AppFont.FONT,
                    color: AppColors.WHITE_3,
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimen.TEXT_SMALLEST,
                  )
                ],
              )
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: trailingIcon??Icon(LineIcons.arrowRight),
          )
        ],
      ),
    );
  }
}

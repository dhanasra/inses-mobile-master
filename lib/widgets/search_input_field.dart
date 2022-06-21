import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/input_field.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:line_icons/line_icons.dart';

class SearchInputField extends StatelessWidget {

  final TextEditingController controller;

  SearchInputField({this.controller});

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      bgColor: AppColors.WHITE,
      borderColor: AppColors.WHITE_3,
      radius: 4,
      margin: EdgeInsets.only(left: 15,right: 15),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child:
              Icon(Icons.search,color: AppColors.GRAY_3,size: 20,),
            margin: EdgeInsets.only(left: 10,right: 0,),
          ),
          Expanded(child:
          InputField(
              text: 'Search for service',
              controller: controller,
              isShadow: false,
              autoFocus: false,
              enabledBorderColor: AppColors.TRANSPARANT,
              errorMaxLines: 3,
              enabledBorderWidth: 1.2,
              focusedBorderColor: AppColors.TRANSPARANT,
              focusedBorderWidth: 1.0,
              bgColor: AppColors.TRANSPARANT,
              hoverColor: AppColors.TRANSPARANT,
              radius: 4,
              color: AppColors.BLACK,
              fontfamily: AppFont.FONT,
              fontWeight: FontWeight.w500,
              fontSize: AppDimen.TEXT_SMALLEST,
              contentPadding: EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              width: 400)
          )
        ],
      )
    );
  }
}

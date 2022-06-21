import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/model/payment_history.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class PaymentCardItem extends StatelessWidget {
  final PaymentHistoryModel payment;

  PaymentCardItem({this.payment});

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      radius: 5,
      bgColor: AppColors.WHITE_1,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Content(
            margin: EdgeInsets.only(bottom: 15),
            text: '\u20B9 2000',
            fontfamily: AppFont.FONT,
            fontWeight: FontWeight.w500,
            fontSize: AppDimen.TEXT_MEDIUM_1,
            alignment: Alignment.centerLeft,
            color: AppColors.BLACK_2,
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child:
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time,size: 15,color: AppColors.GRAY,),
                      Content(
                        margin: EdgeInsets.only(left: 5),
                        text: '12 May, 11.30 pm',
                        color: AppColors.GRAY,
                        fontfamily: AppFont.FONT,
                        fontSize: AppDimen.TEXT_SMALLEST,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                ),
                Expanded(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.monetization_on,size: 15,color: AppColors.GRAY,),
                        Content(
                          padding: EdgeInsets.only(left: 5),
                          text: 'Cash',
                          color: AppColors.GRAY,
                          fontfamily: AppFont.FONT,
                          fontSize: AppDimen.TEXT_SMALLEST,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

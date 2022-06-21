import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/image_container.dart';
import 'package:inses_app/comps/line.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/model/service.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/view_models/order_view_model.dart';
import 'package:inses_app/widgets/review_scroll_card.dart';
import 'package:inses_app/widgets/sub.dart';

class ServiceSubItem extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onpressed;
  ServiceSubItem({this.service,this.onpressed});
  @override
  Widget build(BuildContext context) {
    return Container(
            child: Column(
              children: [
              OnTapField(
              child:
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageContainer(
                      width: 40,
                      bgColor: AppColors.WHITE,
                      height: 40,
                      radius: 100,
                      url: service.icon,
                    ),
                    Expanded(
                        child: Content(
                          margin: EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
                          text: service.name,
                          alignment: Alignment.centerLeft,
                          textAlign: TextAlign.start,
                          textHeight: 1.5,
                          color: AppColors.BLACK,
                          fontfamily: AppFont.FONT,
                          letterSpacing: 0.5,
                          fontSize: AppDimen.TEXT_SMALLEST,
                          fontWeight: FontWeight.w500,
                        )
                    ),
                    Icon(
                        Icons.arrow_right
                    )
                  ],
                ),
                ),
                  onTap: onpressed??(){
                    OrderViewModel.service = service.name;
                    OrderViewModel.serviceId = service.id;
                    OrderViewModel.serviceIcon = service.icon;
                    OrderViewModel.serviceImage = service.image;
                    OrderViewModel.basePrice = service.price;
                    App().setNavigation(context, AppRoutes.APP_ORDER_FLOW_2);
                  }
              ),
                Line(width: double.infinity, height: 2,color: AppColors.WHITE_1,margin: EdgeInsets.only(left: 10,right: 10),),

              ],
            )
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/image_view.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/model/category.dart';
import 'package:inses_app/model/service.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/view_models/order_view_model.dart';

class ServiceItem extends StatelessWidget {
  final CategoryModel serviceModel;
  final VoidCallback onPressed;

  ServiceItem({this.serviceModel,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OnTapField(
        child: Card(
          elevation: 1,
          child: BorderContainer(
            radius: 5,
            bgColor: AppColors.WHITE,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 50,
                  height: 50,
                  child: ImageView(
                    width: 50,
                    url: serviceModel.image,
                  ),
                ),
                Content(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  textAlign: TextAlign.center,
                  textHeight: 1.2,
                  text: serviceModel.name,
                  fontfamily: AppFont.FONT,
                  color: AppColors.BLACK,
                  fontWeight: FontWeight.w500,
                  fontSize: AppDimen.TEXT_SMALLEST,
                )
              ],
            ),
          ),
        ),
        onTap: onPressed??(){
          OrderViewModel.categoryId = serviceModel.id;
          OrderViewModel.category = serviceModel.name;
          App().setNavigation(context, AppRoutes.APP_ORDER_FLOW_1);
        }
    );
  }
}

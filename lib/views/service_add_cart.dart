import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/image_container.dart';
import 'package:inses_app/comps/line.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/view_models/order_view_model.dart';
import 'package:inses_app/widgets/sub.dart';

class ServiceAddCart extends StatefulWidget {

  @override
  _ServiceAddCartState createState() => _ServiceAddCartState();
}

class _ServiceAddCartState extends State<ServiceAddCart> {
  StreamController controller;
  int items = 1;

  @override
  void initState() {
    controller = StreamController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App().appBarBack(
        context,
        'Select your services',
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            OnTapField(
                child: BorderContainer(
                  bgColor: AppColors.SECONDARY_COLOR,
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                  radius: 4,
                  child: Content(
                    color:AppColors.WHITE,
                    text: 'Continue',
                    fontfamily: AppFont.FONT,
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimen.TEXT_SMALL,
                  ),
                ),
                onTap:(){
                  if(items==0){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Select atleast 1 service',style: TextStyle(fontSize: AppDimen.TEXT_SMALL),)));
                  }else{
                    OrderViewModel.noOfService = items;
                    OrderViewModel.totalPrice = items*OrderViewModel.basePrice;
                    App().setNavigation(context, AppRoutes.APP_ORDER_FLOW_3);
                  }
                }
            )
          ],
        ),
      ),
      body: Container(
        child: buildView(),
      ),
    );
  }

  Widget buildView(){
    return ListView(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BorderContainer(
              margin: EdgeInsets.all(20),
              bgColor: AppColors.SECONDARY_COLOR,
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              radius: 4,
              child: Content(
                color:AppColors.WHITE,
                text: '${OrderViewModel.category}',
                fontfamily: AppFont.FONT,
                fontWeight: FontWeight.w500,
                fontSize: AppDimen.TEXT_SMALL,
              ),
            )
          ],
        ),
        Line(
          width: double.infinity,
          height: 5,
          color: AppColors.WHITE_1,
          margin: EdgeInsets.only(top: 0, bottom: 10),
        ),
        ImageContainer(
          margin: EdgeInsets.only(left: 15,right: 15,top: 10),
          radius: 5,
          height: 150,
          url: OrderViewModel.serviceImage,
        ),
        Container(
          margin: EdgeInsets.only(left: 15,right: 15,top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                    children: [
                      Content(
                        padding: EdgeInsets.only(bottom: 12),
                        text: '${OrderViewModel.service}',
                        color: AppColors.BLACK,
                        alignment: Alignment.centerLeft,
                        fontfamily: AppFont.FONT,
                        fontSize: AppDimen.TEXT_SMALL,
                        fontWeight: FontWeight.w500,
                      ),
                      Content(
                        text: '\u20B9 ${OrderViewModel.basePrice}',
                        color: AppColors.BLACK,
                        alignment: Alignment.centerLeft,
                        fontfamily: AppFont.FONT,
                        fontSize: AppDimen.TEXT_SMALL,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  )
              ),
              addItems()
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15,right: 15,top: 20),
          child: Row(
            children: [
              Icon(Icons.check,color: AppColors.SECONDARY_COLOR,),
              Content(
                margin: EdgeInsets.only(left: 5),
                text: 'Material Cost will be additional, if any',
                color: AppColors.GRAY,
                fontfamily: AppFont.FONT,
                fontSize: AppDimen.TEXT_SMALLEST,
                fontWeight: FontWeight.w500,
              )
            ],
          ),
        ),
        Line(
          width: double.infinity,
          height: 2,
          color: AppColors.WHITE_1,
          margin: EdgeInsets.only(top: 20, bottom: 10),
        ),
      ],
    );
  }

  Widget addItems(){
    return StreamBuilder(
        stream: controller.stream,
        builder: (context,AsyncSnapshot shot){
          if(!shot.hasData || shot.data==0){
            return OnTapField(
                child: BorderContainer(
                  bgColor: AppColors.SECONDARY_COLOR,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                  radius: 4,
                  child: Content(
                    color:AppColors.WHITE,
                    text: 'ADD',
                    fontfamily: AppFont.FONT,
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimen.TEXT_SMALL,
                  ),
                ),
                onTap: (){
                  if(items==0){
                    controller.add(++items);
                  }else{
                    controller.add(items);
                  }
                }
            );
          } else{
            return BorderContainer(
              borderColor: AppColors.WHITE_3,
              radius: 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OnTapField(
                      child:Content(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        color:AppColors.SECONDARY_COLOR,
                        text: '-',
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALL,
                      ),
                      onTap: (){
                        controller.add(--items);
                      }
                  ),
                  Content(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    width: 70,
                    color:AppColors.BLACK,
                    text: '${shot.data}',
                    fontfamily: AppFont.FONT,
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimen.TEXT_SMALL,
                  ),
                  OnTapField(
                      child: Content(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        color:AppColors.SECONDARY_COLOR,
                        text: '+',
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALL,
                      ),
                      onTap: (){
                        controller.add(++items);
                      }
                  ),
                ],
              ),
            );
          }
        }
    );
  }

}

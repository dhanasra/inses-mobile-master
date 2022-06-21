import 'package:flutter/cupertino.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/image_view.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class EmptyBooking extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageView(
              width: 100,
              height: 100,
              asset: 'empty.png',
          ),
          Content(
            color:AppColors.BLACK,
            margin: EdgeInsets.only(top: 5,left: 50,right: 50),
            text: 'No Booking found',
            overflow: TextOverflow.ellipsis,
            fontfamily: AppFont.FONT,
            fontWeight: FontWeight.w500,
            fontSize: AppDimen.TEXT_SMALLER,
            alignment: Alignment.center,
            textHeight: 1.5,
          ),
          Content(
            margin: EdgeInsets.only(top: 15,left: 50,right: 50),
            color:AppColors.GRAY,
            textAlign: TextAlign.center,
            text: "Looks like you don't have any bookings here but you can request for a service now",
            fontfamily: AppFont.FONT,
            fontWeight: FontWeight.w500,
            fontSize: AppDimen.TEXT_SMALLEST,
            alignment: Alignment.center,
            textHeight: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OnTapField(
                  child: BorderContainer(
                    margin: EdgeInsets.all(20),
                    bgColor: AppColors.SECONDARY_COLOR,
                    padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                    radius: 2,
                    child: Content(
                      color:AppColors.WHITE,
                      text: 'Book now',
                      fontfamily: AppFont.FONT,
                      fontWeight: FontWeight.w500,
                      fontSize: AppDimen.TEXT_SMALL,
                    ),
                  ),
                  onTap:(){
                    App().setNavigation(context, AppRoutes.APP_HOME_MAIN);
                  }
              )
            ],
          )
        ],
      ),
    );
  }
}

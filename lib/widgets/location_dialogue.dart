import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';

class LocationDialogue extends StatelessWidget {

  final String title;
  final String description;
  final String text;
  final VoidCallback onPressed;
  final Icon icon;

  LocationDialogue({
    this.text,
    this.title,
    this.icon,
    this.description,
    this.onPressed
});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context){
    return Stack(
      children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20,top: 35, right: 20,bottom: 20
                ),
                margin: EdgeInsets.only(top: 45),
                decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Colors.black,offset: Offset(0,10),
                   blurRadius: 10
                  ),
                ]
                ),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Content(
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    text: title,
                    alignment: Alignment.center,
                    textAlign: TextAlign.start,
                    textHeight: 1.5,
                    color: AppColors.BLACK,
                    fontfamily: AppFont.FONT,
                    letterSpacing: 1.2,
                    fontSize: AppDimen.TEXT_H5,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 15,),
                  Content(
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    text: description,
                    alignment: Alignment.center,
                    textAlign: TextAlign.center,
                    textHeight: 1.5,
                    color: AppColors.GRAY_1,
                    fontfamily: AppFont.FONT,
                    letterSpacing: 1.2,
                    fontSize: AppDimen.TEXT_SMALL,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 22,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: onPressed,
                            child: Content(
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              text: text,
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              textHeight: 1.5,
                              color: AppColors.BLACK_3,
                              fontfamily: AppFont.FONT,
                              letterSpacing: 1.2,
                              fontSize: AppDimen.TEXT_SMALLEST,
                              fontWeight: FontWeight.w500,
                            ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child:Content(
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              text: 'Not now',
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              textHeight: 1.5,
                              color: AppColors.GRAY,
                              fontfamily: AppFont.FONT,
                              letterSpacing: 1.2,
                              fontSize: AppDimen.TEXT_SMALLEST,
                              fontWeight: FontWeight.w500,
                            ),
                        ),
                      ),
                    ],
                  )
                ],
                ),
          ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 5,
            child: BorderContainer(
              radius: 40,
              bgColor: AppColors.WHITE,
              padding: EdgeInsets.all(5),
              child: icon??Icon(Icons.location_on,color: AppColors.PRIMARY_COLOR,),
            )
          )
        )
      ],
    );
  }
}

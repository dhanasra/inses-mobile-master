import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/image_view.dart';
import 'package:inses_app/comps/line.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/database/constants.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/view_models/profile_view_model.dart';
import 'package:inses_app/widgets/grey_micro.dart';
import 'package:inses_app/widgets/profile_option.dart';
import 'package:inses_app/widgets/sub_title.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: App().appBarBack(context, 'Profile',onPressed: (){App().setNavigation(context, AppRoutes.APP_HOME_MAIN);}),
      body: Container(
        child: buildView(),
      ),
    ), onWillPop:() async{
      App().setNavigation(context, AppRoutes.APP_HOME_MAIN);
      return true;
    }
    );
  }

  Widget buildView(){
    return Container(
      child: ListView(
        children: [
          Container(
            color: AppColors.SECONDARY_COLOR,
            child: Row(
              children: [
                BorderContainer(
                  radius: 100,
                  bgColor: AppColors.WHITE_1,
                  margin: EdgeInsets.all(20),
                  child: Content(
                    margin: EdgeInsets.all(20),
                    text:ProfileViewModel.name.length>2? ProfileViewModel.name.substring(0,2).toUpperCase():"IN",
                    textHeight: 1.5,
                    color: AppColors.PRIMARY_COLOR,
                    fontfamily: AppFont.FONT,
                    letterSpacing: 1.2,
                    fontSize: AppDimen.TEXT_H1_LARGE,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Content(
                            alignment: Alignment.centerLeft,
                            text: ProfileViewModel.name,
                            textHeight: 1.5,
                            color: AppColors.WHITE,
                            fontfamily: AppFont.FONT,
                            letterSpacing: 1.2,
                            fontSize: AppDimen.TEXT_H7,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.SECONDARY_COLOR,
            child:Row(
              children: [
                Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Content(
                            bgColor: AppColors.SECONDARY_COLOR,
                            padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 0),
                            text: 'PHONE NUMBER',
                            textHeight: 1.5,
                            alignment: Alignment.centerLeft,
                            textAlign: TextAlign.start,
                            color: AppColors.WHITE,
                            fontfamily: AppFont.FONT,
                            letterSpacing: 1,
                            fontSize: AppDimen.TEXT_MEDIUM_3,
                            fontWeight: FontWeight.w500,
                          ),
                          Content(
                            bgColor: AppColors.SECONDARY_COLOR,
                            padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                            text: ProfileViewModel.phone,
                            alignment: Alignment.centerLeft,
                            textAlign: TextAlign.start,
                            textHeight: 1.5,
                            color: AppColors.WHITE,
                            fontfamily: AppFont.FONT,
                            letterSpacing: 1,
                            fontSize: AppDimen.TEXT_SMALL,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    )
                ),
                BorderContainer(
                  radius: 50,
                  borderColor: AppColors.WHITE_1,
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(2),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: Icon(Icons.edit,color: AppColors.WHITE,size: 20,),
                      onPressed: (){
                        App().setNavigation(context, AppRoutes.APP_SETTINGS);
                      },
                    ),
                  )
                )
              ],
            ),
          ),
          Line(width:100, height: 3,color: AppColors.WHITE_1,margin: EdgeInsets.only(bottom: 30),),
          ProfileOption(
            option: 'Settings',
            sub: 'Change account password',
            icon: Icons.settings,
            onPressed: (){
              App().setNavigation(context, AppRoutes.APP_PASSWORD_SETTINGS);
            },
          ),
          ProfileOption(
            option: 'About',
            sub: 'About Inses app',
            icon: Icons.info_outline,
            onPressed: (){
              App().setNavigation(context, AppRoutes.APP_ABOUT);
            },
          ),
          ProfileOption(
            option: 'Contact',
            sub: 'Send Message / Query / Feedback to us',
            icon: Icons.chat_outlined,
            onPressed: (){
              App().setNavigation(context, AppRoutes.APP_CONTACT);
            },
          ),
          ProfileOption(
            option: 'Call',
            sub: 'Call us for your query',
            icon: Icons.phone,
            onPressed: (){
              launch("tel://${AppConstants.INSES_NUMBER}");
            },
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/primary_button.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/widgets/double_color_button.dart';
import 'package:inses_app/widgets/launch_slider_item.dart';
import 'package:inses_app/widgets/loader.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Launch extends StatefulWidget {

  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {

  int _currentPage = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildView(),
    );
  }

  Widget buildView(){
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            color: AppColors.WHITE_1,
            child: SizedBox(
                height:500,
                child:PageView(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  children: [
                    LaunchSliderItem(
                      text: 'Online service booking',
                      subText: 'Lowest price online booking home services',
                      image: 'electric.png',
                    ),
                    LaunchSliderItem(
                      text: 'Flawless repair fixing',
                      subText: 'Fasted & flawless repair fixing for trusted customers',
                      image: 'maintain.png',
                    ),
                    LaunchSliderItem(
                      text: 'Customer help center',
                      subText: 'Continuous Customer support & help available for 24 hours',
                      image: 'support.png',
                    ),
                  ],
                )),
          ),
          Container(
            color: AppColors.WHITE_1,
            padding: EdgeInsets.only(left: 15,right: 15,bottom: 20),
            alignment: Alignment.center,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: JumpingDotEffect(dotWidth: 5, dotHeight: 5),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 50,left: 25,right: 25),
              alignment: Alignment.center,
              child:Wrap(
                  children:[
                    PrimaryButton(
                        text: 'Create Account',
                        txtColor: AppColors.WHITE,
                        width: double.infinity,
                        bgColor: AppColors.PRIMARY_COLOR,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALL,
                        radius: 5,
                        onPressed:(){
                          App().setNavigation(context, AppRoutes.APP_REGISTER);
                        }),
                  ]
              )
          ),
          Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              margin: EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child:Wrap(
                  children:[
                    DoubleColorButton(
                        text1: 'Already have an account? ',
                        text2: 'Signin',
                        txtColor: AppColors.BLACK,
                        width: 250,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimen.TEXT_SMALL,
                        onPressed:(){
                          App().setNavigation(context, AppRoutes.APP_LOGIN);
                        })
                  ]
              )
          ),
        ],
      ),
    );
  }

  startTimer() {
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.jumpToPage(_currentPage);
    });
  }
}

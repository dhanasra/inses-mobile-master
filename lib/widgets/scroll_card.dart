import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/elevated_button.dart';
import 'package:inses_app/comps/image_container.dart';
import 'package:inses_app/comps/image_view.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/comps/two_wave_clipper.dart';
import 'package:inses_app/model/offer.dart';
import 'package:inses_app/model/service.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ScrollCard extends StatefulWidget {
  final List<OfferModel> offers;
  ScrollCard({this.offers});

  @override
  _ScrollCardState createState() => _ScrollCardState();
}

class _ScrollCardState extends State<ScrollCard> {
  int _currentPage = 0;
  PageController _pageController;

  List<OfferModel> scrolls;

  @override
  void initState() {
    super.initState();
    scrolls = widget.offers;
    _pageController = PageController(
      initialPage: 0,
    );
    startTimer();
  }

  startTimer() {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < scrolls.length-1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.jumpToPage(_currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            width: 500,
            height: 240,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemCount: scrolls.length,
              itemBuilder: (context,index) {
                return pageItem(
                    offer: scrolls[index]
                );
              }
          )),
        Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: scrolls.length,
                effect: JumpingDotEffect(dotWidth: 5, dotHeight: 5),
              ),
            ))
      ],
    );
  }

  Widget pageItem({OfferModel offer}) {
    return OnTapField(
        child: Container(
            padding: EdgeInsets.all(10),
            height: 140,
            child: Card(
                elevation: 5,
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child:  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 15,bottom: 15),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Content(
                              alignment: Alignment.centerLeft,
                              text:"\u20B9 "+offer.old,
                              decoration: TextDecoration.lineThrough,
                              fontfamily: AppFont.FONT,
                              color: AppColors.WARNING_COLOR,
                              fontWeight: FontWeight.w500,
                              fontSize: AppDimen.TEXT_MEDIUM_3,
                            ),
                            Flexible(child: Content(
                              padding: EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              text:offer.txt,
                              overflow: TextOverflow.ellipsis,
                              fontfamily: AppFont.FONT,
                              color: AppColors.BLACK,
                              fontWeight: FontWeight.w500,
                              fontSize: AppDimen.TEXT_MEDIUM_3,
                            ),),
                            Content(
                              alignment: Alignment.centerLeft,
                              text:"\u20B9 "+offer.offer,
                              fontfamily: AppFont.FONT,
                              color: AppColors.BLACK,
                              fontWeight: FontWeight.w500,
                              fontSize: AppDimen.TEXT_MEDIUM_3,
                            ),
                          ],
                        ),
                      ),
                      new Image.network(
                        offer.img,
                        fit: BoxFit.cover,
                        height: 169,
                        width: double.infinity,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                )
            ),
        onTap: (){

        });
  }
}

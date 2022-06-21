import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/elevated_button.dart';
import 'package:inses_app/comps/image_container.dart';
import 'package:inses_app/comps/image_view.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/comps/two_wave_clipper.dart';
import 'package:inses_app/model/offer.dart';
import 'package:inses_app/model/review.dart';
import 'package:inses_app/model/service.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ReviewScrollCard extends StatefulWidget {
  final List<ReviewModel> reviews;
  ReviewScrollCard({this.reviews});
  @override
  _ReviewScrollCardState createState() => _ReviewScrollCardState();
}

class _ReviewScrollCardState extends State<ReviewScrollCard> {
  int _currentPage = 0;
  PageController _pageController;

  List<ReviewModel> scrolls;

  @override
  void initState() {
    super.initState();
    scrolls = widget.reviews;
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              width: 500,
              height: 250,
              child: Stack(
                children: [
                  PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      itemCount: scrolls.length,
                      itemBuilder: (context,index) {
                        return pageItem(
                            review: scrolls[index]
                        );
                      }
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: OnTapField(
                        child: BorderContainer(
                          radius: 100,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(3),
                          bgColor: AppColors.WHITE,
                          child: Icon(Icons.arrow_left),
                        ),
                        onTap: (){
                          if (_currentPage < scrolls.length-1) {
                            _currentPage++;
                          } else {
                            _currentPage = 0;
                          }
                          _pageController.jumpToPage(_currentPage);
                        },
                      )
                    )
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                        child: OnTapField(
                          onTap: (){
                            if (_currentPage >0) {
                              _currentPage--;
                            } else {
                              _currentPage = scrolls.length;
                            }
                            _pageController.jumpToPage(_currentPage);
                          },
                          child: BorderContainer(
                            radius: 100,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(3),
                            bgColor: AppColors.WHITE,
                            child: Icon(Icons.arrow_right),
                          ),
                        )
                      )
                  )
                ],
              )
    );
  }

  Widget pageItem({ReviewModel review}) {
    return OnTapField(
        child: Container(
            color: AppColors.WHITE_1,
            padding: EdgeInsets.all(10),
            height: 200,
            child:Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BorderContainer(
                              radius: 100,
                              bgColor: AppColors.WHITE,
                              margin: EdgeInsets.all(10),
                              child: Content(
                                margin: EdgeInsets.all(10),
                                text:review.img.toUpperCase(),
                                textHeight: 1.5,
                                color: AppColors.PRIMARY_COLOR,
                                fontfamily: AppFont.FONT,
                                letterSpacing: 1.2,
                                fontSize: AppDimen.TEXT_H1_LARGE,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Expanded(
                                child: Column(
                                  children: [
                                    Content(
                                      padding: EdgeInsets.only(left: 20),
                                      alignment: Alignment.centerLeft,
                                      text:review.name,
                                      fontfamily: AppFont.FONT,
                                      color: AppColors.BLACK,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppDimen.TEXT_SMALL,
                                    ),
                                    Content(
                                      padding: EdgeInsets.only(left: 20,top: 10),
                                      alignment: Alignment.centerLeft,
                                      text:review.date,
                                      fontfamily: AppFont.FONT,
                                      color: AppColors.GRAY,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppDimen.TEXT_SMALLEST,
                                    ),
                                  ],
                                )
                            ),
                            Container(
                              child: RatingBarIndicator(
                                rating: review.stars.toDouble(),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                                direction: Axis.horizontal,
                              ),
                            )
                          ],
                        ),
                      ),
                      Content(
                        padding: EdgeInsets.only(left: 50,right: 50),
                        alignment: Alignment.centerLeft,
                        text:"\" ${review.review} \"",
                        textHeight: 2,
                        fontfamily: AppFont.FONT,
                        color: AppColors.BLACK,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALL,
                      ),
                    ],
                  ),
                ),
        onTap: (){

        });
  }
}

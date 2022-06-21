import 'dart:convert';
import 'package:inses_app/database/constants.dart';
import 'package:inses_app/main.dart';
import 'package:inses_app/views/splash.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/image_view.dart';
import 'package:inses_app/comps/line.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/database/app_preferences.dart';
import 'package:inses_app/model/service.dart';
import 'package:inses_app/network/app_api_client.dart';
import 'package:inses_app/network/app_repository.dart';
import 'package:inses_app/network/bloc/network_bloc.dart';
import 'package:inses_app/network/bloc/network_event.dart';
import 'package:inses_app/network/bloc/network_state.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/utils/url.dart';
import 'package:inses_app/view_models/home_view_model.dart';
import 'package:inses_app/widgets/app_drawer.dart';
import 'package:inses_app/widgets/loader.dart';
import 'package:inses_app/widgets/location_dialogue.dart';
import 'package:inses_app/widgets/promise_item.dart';
import 'package:inses_app/widgets/review_scroll_card.dart';
import 'package:inses_app/widgets/scroll_card.dart';
import 'package:inses_app/widgets/search_input_field.dart';
import 'package:inses_app/widgets/service_item.dart';
import 'package:inses_app/widgets/sub.dart';
import 'package:inses_app/widgets/sub_title.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NetworkBloc bloc;
  NetworkBloc bloc1;
  NetworkBloc categoryBloc;
  NetworkBloc reviewBloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    bloc = NetworkBloc(appRepository: appRepository);
    bloc1 = NetworkBloc(appRepository: appRepository);
    bloc1.add(GetOffers());
    categoryBloc = NetworkBloc(appRepository: appRepository);
    reviewBloc = NetworkBloc(appRepository: appRepository);
    categoryBloc.add(GetCategories());
    reviewBloc.add(GetReview());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(logout),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          color: AppColors.SECONDARY_COLOR,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      OnTapField(
                        child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.menu,
                              color: AppColors.WHITE_1,
                            ),),
                            onTap: (){
                              _scaffoldKey.currentState.openDrawer();
                            }
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        ImageView(
                          width: 90,
                          asset: 'logo-h2.png',
                        ),
                        Content(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          alignment: Alignment.centerLeft,
                          text: 'Online services',
                          fontfamily: AppFont.FONT,
                          color: AppColors.WHITE_3,
                          fontWeight: FontWeight.w400,
                          fontSize: AppDimen.TEXT_SMALLEST,
                        )
                      ],
                    ))
                  ],
                ),
              ),
              Line(
                width: double.infinity,
                height: 3,
                color: AppColors.WHITE_1,
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<NetworkBloc,NetworkState>(
        bloc: bloc,
        builder: (context,state){
          if(state is LogoutSuccess){
            print("success");
            Future.delayed(Duration.zero,()async{
              RestartWidget.restartApp(context);
            });
          }
          return Container(
              color: AppColors.WHITE,
              child: Container(
                child: buildView(),
              ),
          );
        },
      )
    );
  }

  Widget buildView() {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Content(
                      alignment: Alignment.centerRight,
                      text: '24',
                      fontfamily: AppFont.FONT,
                      color: AppColors.PRIMARY_COLOR,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimen.TEXT_H4,
                    ),
                    Content(
                      alignment: Alignment.centerRight,
                      text: ' x ',
                      fontfamily: AppFont.FONT,
                      color: AppColors.BLACK,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimen.TEXT_SMALL,
                    ),
                    Content(
                      alignment: Alignment.centerRight,
                      text: '7',
                      fontfamily: AppFont.FONT,
                      color: AppColors.PRIMARY_COLOR,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimen.TEXT_H4,
                    ),
                    Content(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerRight,
                      text: 'Available',
                      fontfamily: AppFont.FONT,
                      color: AppColors.BLACK,
                      fontWeight: FontWeight.w400,
                      fontSize: AppDimen.TEXT_SMALLEST,
                    )
                  ],
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: OnTapField(
                  child:  BorderContainer(
                    radius: 20,
                    padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    borderColor: AppColors.GRAY,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 18,
                          color: AppColors.BLACK,
                        ),
                        Content(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerRight,
                          text: AppConstants.INSES_NUMBER,
                          fontfamily: AppFont.FONT,
                          color: AppColors.BLACK,
                          fontWeight: FontWeight.w400,
                          fontSize: AppDimen.TEXT_SMALLEST,
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    launch("tel://${AppConstants.INSES_NUMBER}");
                  },
                )
              ))
            ],
          ),
        ),
        // SearchInputField(),
        BlocBuilder<NetworkBloc,NetworkState>(
          bloc: bloc1,
          builder: (context,state){
            if(state is GotOffers){
              return ScrollCard(offers: state.offers);
            }else if(state is Loading){
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Loader(),
                    margin: EdgeInsets.all(20),
                  )
                ],
              );
            }else{
              return Container();
            }
          },
        ),
        Line(
          width: double.infinity,
          height: 10,
          color: AppColors.WHITE_1,
          margin: EdgeInsets.only(top: 20, bottom: 10),
        ),
        Sub(
          text: 'Services',
        ),
        Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
                AppColors.WHITE_1,
                AppColors.WHITE,
              ], radius: 0.85, focal: Alignment.center),
            ),
            child: BlocBuilder<NetworkBloc,NetworkState>(
              bloc: categoryBloc,
              builder: (context,state){
                if(state is Loading){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Loader(),
                        margin: EdgeInsets.all(20),
                      )
                    ],
                  );
                }else if(state is GotCategories){
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.categories.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                    ),
                    itemBuilder: (context, index) {
                      return ServiceItem( 
                        serviceModel: state.categories[index],
                      );
                    },
                  );
                }else{
                  return Container();
                }
              },
            )
        ),
        Line(
          width: double.infinity,
          height: 10,
          color: AppColors.WHITE_1,
          margin: EdgeInsets.only(top: 20, bottom: 10),
        ),
        Sub(
          text: 'INSES Promises',
        ),
        PromiseItem(
          img: Icon(
            Icons.monetization_on,
            color: AppColors.TAMIL,
            size: 30,
          ),
          text1: 'Suitable Prices',
          text2: 'Appropriate cost ,neither lesser nor higher',
        ),
        PromiseItem(
          img: Icon(
            Icons.verified_user_rounded,
            color: AppColors.SUCCESS_COLOR,
            size: 30,
          ),
          text1: 'Free cancellation & reschedule',
          text2: 'Wanna cancel or reschedule?  not a problem. No charges',
        ),
        PromiseItem(
          img: Icon(
            Icons.verified,
            color: AppColors.INFO_COLOR,
            size: 30,
          ),
          text1: 'Ace Professionals',
          text2:
              'Best professionals. Hand-picked gems. We never trade-off quality',
        ),
        Line(
          width: double.infinity,
          height: 10,
          color: AppColors.WHITE_1,
          margin: EdgeInsets.only(top: 20, bottom: 10),
        ),
        Sub(
          text: 'Customer stories',
        ),
        BlocBuilder<NetworkBloc,NetworkState>(
          bloc: reviewBloc,
          builder: (context,state){
            if(state is GotReviews){
              return ReviewScrollCard(reviews: state.reviews,);
            }else if(state is Loading){
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Loader(),
                    margin: EdgeInsets.all(20),
                  )
                ],
              );
            }else{
              return Container();
            }
          },
        ),
      ],
    );
  }

  void logout(){
    Future.delayed(Duration.zero, () {
      this.showDialogue();
    });
  }

  showDialogue(){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return LocationDialogue(
              title: "Logout",
              description: "Are you want to logout ?",
              text: "Yes",
              onPressed:(){
                bloc.add(Logout());
                Navigator.of(context).pop();
              }
          );
        }
    );
  }

}

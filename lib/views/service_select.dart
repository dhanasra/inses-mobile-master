import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/image_container.dart';
import 'package:inses_app/comps/line.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/database/constants.dart';
import 'package:inses_app/model/service.dart';
import 'package:inses_app/network/app_api_client.dart';
import 'package:inses_app/network/app_repository.dart';
import 'package:inses_app/network/bloc/network_bloc.dart';
import 'package:inses_app/network/bloc/network_event.dart';
import 'package:inses_app/network/bloc/network_state.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/view_models/order_view_model.dart';
import 'package:inses_app/widgets/error_item.dart';
import 'package:inses_app/widgets/loader.dart';
import 'package:inses_app/widgets/mini_card_item.dart';
import 'package:inses_app/widgets/mini_title.dart';
import 'package:inses_app/widgets/promise_item.dart';
import 'package:inses_app/widgets/review_scroll_card.dart';
import 'package:inses_app/widgets/service_sub_item.dart';
import 'package:inses_app/widgets/sub.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceSelect extends StatefulWidget {

  @override
  _ServiceSelectState createState() => _ServiceSelectState();
}

class _ServiceSelectState extends State<ServiceSelect> {

  NetworkBloc bloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));
  OrderViewModel viewModel;
  NetworkBloc reviewBloc;

  @override
  void initState() {
    super.initState();
    viewModel = OrderViewModel(App());
    bloc = NetworkBloc(appRepository: appRepository);
    bloc.add(GetCategoryServices(id: OrderViewModel.categoryId));
    reviewBloc = NetworkBloc(appRepository: appRepository);
    reviewBloc.add(GetReview());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App().appBarBack(
          context,
          'Select your need',
      ),
      body: Container(
        child: BlocBuilder<NetworkBloc,NetworkState>(
          bloc: bloc,
          builder: (context,state){
            if(state is Initial || state is Loading){
              return buildView(true,[]);
            }else if(state is Error){
              return ErrorItem();
            }else if(state is GotServices){
              return buildView(false,state.services);
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget buildView(bool isLoading,List<ServiceModel> services){
    return ListView(
      children: [
          Stack(
            children: [
              ImageContainer(
                height: 300,
                width: double.infinity,
                radius: 0,
                url: 'https://images.unsplash.com/photo-1596394723269-b2cbca4e6313?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHBsdW1iaW5nfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
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
                                      color: AppColors.SUCCESS_COLOR_EXTRA_LIGHT,
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppDimen.TEXT_H4,
                                    ),
                                    Content(
                                      alignment: Alignment.centerRight,
                                      text: ' x ',
                                      fontfamily: AppFont.FONT,
                                      color: AppColors.WHITE,
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppDimen.TEXT_SMALL,
                                    ),
                                    Content(
                                      alignment: Alignment.centerRight,
                                      text: '7',
                                      fontfamily: AppFont.FONT,
                                      color: AppColors.SUCCESS_COLOR_EXTRA_LIGHT,
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppDimen.TEXT_H4,
                                    ),
                                    Content(
                                      padding: EdgeInsets.only(left: 10),
                                      alignment: Alignment.centerRight,
                                      text: 'Available',
                                      fontfamily: AppFont.FONT,
                                      color: AppColors.WHITE,
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
                                  child: BorderContainer(
                                    radius: 20,
                                    padding:
                                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                    borderColor: AppColors.WHITE,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 18,
                                          color: AppColors.WHITE,
                                        ),
                                        Content(
                                          padding: EdgeInsets.only(left: 10),
                                          alignment: Alignment.centerRight,
                                          text: AppConstants.INSES_NUMBER,
                                          fontfamily: AppFont.FONT,
                                          color: AppColors.WHITE,
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
                    Content(
                      padding: EdgeInsets.only(top: 20,left: 15,right: 15),
                      alignment: Alignment.centerLeft,
                      fontfamily: AppFont.FONT,
                      textHeight: 1.5,
                      letterSpacing: 1,
                      text: 'Best ${OrderViewModel.category} Services in Madurai',
                      color: AppColors.WHITE,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimen.TEXT_H1,
                    ),
                    Content(
                      padding: EdgeInsets.only(top: 10,left: 15,right: 15),
                      alignment: Alignment.centerLeft,
                      fontfamily: AppFont.FONT,
                      textHeight: 1.5,
                      text: 'Get lowest prices for ${OrderViewModel.category} services in Madurai',
                      color: AppColors.WHITE_1,
                      fontWeight: FontWeight.w400,
                      fontSize: AppDimen.TEXT_SMALL,
                    )
                  ],
                ),
              ),
              Card(
                elevation: 4,
                margin: EdgeInsets.only(top: 250,left: 10,right: 10),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      MiniTitle(text: 'Select what you need',margin: EdgeInsets.only(bottom: 20),),
                      isLoading?Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Loader()
                        ],
                      ):ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: services.length,
                          itemBuilder: (context,index){
                            return ServiceSubItem(service: services[index],);
                          }
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        Sub(
          text: 'How it works',
        ),
        PromiseItem(
          img: Icon(
            Icons.book_rounded,
            color: AppColors.TAMIL,
            size: 30,
          ),
          text1: 'How can we serve you?',
          text2: 'Get our quality service at appropriate price',
        ),
        PromiseItem(
          img: Icon(
            Icons.payment,
            color: AppColors.SUCCESS_COLOR,
            size: 30,
          ),
          text1: 'Pay in advance',
          text2: 'Pay on time or prior',
        ),
        PromiseItem(
          img: Icon(
            Icons.check_circle,
            color: AppColors.INFO_COLOR,
            size: 30,
          ),
          text1: 'Get hassle free service delivery:',
          text2:
          'Sit back ,relax, watch your door step for our service on time',
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
          text1: 'Suitable prices',
          text2: 'Appropriate cost ,neither lesser nor higher',
        ),
        PromiseItem(
          img: Icon(
            Icons.verified_user_rounded,
            color: AppColors.SUCCESS_COLOR,
            size: 30,
          ),
          text1: 'Free Cancellation & Reschedule',
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
          'Best professionals. Hand-picked gems. We never trade-off quality ',
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
}

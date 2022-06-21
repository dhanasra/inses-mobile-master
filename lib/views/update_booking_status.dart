import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/image_container.dart';
import 'package:inses_app/comps/line.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/database/constants.dart';
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

class UpdateBookingStatus extends StatefulWidget {

  @override
  _UpdateBookingStatusState createState() => _UpdateBookingStatusState();
}

class _UpdateBookingStatusState extends State<UpdateBookingStatus> {
  NetworkBloc bloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));

  String type;
  String payType;
  String additional;

  @override
  void initState() {
    type = OrderViewModel.booking.status;
    payType = OrderViewModel.booking.payStatus;
    bloc = NetworkBloc(appRepository: appRepository);
    OrderViewModel.load4 = true;
    bloc.add(GetBookingDetails(id: OrderViewModel.booking.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: App().appBarBack(
            context,
            OrderViewModel.booking.categoryName,
          ),
          body: Container(
              padding: EdgeInsets.only(bottom: 0),
              child: BlocBuilder<NetworkBloc,NetworkState>(
                bloc: bloc,
                builder: (context,state){
                  if(state is Empty || state is Loading){
                    return buildView(OrderViewModel.load4,OrderViewModel.load3,OrderViewModel.load1,OrderViewModel.load2);
                  }else if(state is Error){
                    return ErrorItem();
                  }else if( state is Approved || state is Completed || state is PaymentStatusUpdated || state is Added || state is GotBooking || state is AdditionalRemoved){
                    if(state is GotBooking){
                      OrderViewModel.booking = state.booking;
                      type = OrderViewModel.booking.status;
                      additional = OrderViewModel.booking.additionalPrice!=0?"ADDED":"ADD";
                      print(additional);
                    }
                    if(state is AdditionalRemoved){
                      Future.delayed(Duration.zero, () async {
                        setState(() {
                          type = "ADD";
                        });
                      });
                      bloc.add(GetBookingDetails(id: OrderViewModel.booking.id));
                    }
                    if(state is Approved){
                      Future.delayed(Duration.zero, () async {
                        setState(() {
                          type = "APPROVED";
                        });
                      });
                    }
                    if(state is Completed){
                      Future.delayed(Duration.zero, () async {
                        setState(() {
                          type = "COMPLETED";
                        });
                      });
                    }
                    if(state is PaymentStatusUpdated){
                      Future.delayed(Duration.zero, () async {
                        setState(() {
                          payType = "UPDATED";
                        });
                      });
                    }
                    if(state is Added){
                      Future.delayed(Duration.zero, () async {
                        setState(() {
                          additional = "ADDED";
                        });
                      });
                    }
                    OrderViewModel.load1 = false;
                    OrderViewModel.load2 = false;
                    OrderViewModel.load4 = false;
                    OrderViewModel.load3 = false;
                    return buildView(false,false,false,false);
                  }else{
                    return Container();
                  }
                },
              )
          ),
        ),
        onWillPop: ()async{
          App().setNavigation(context, AppRoutes.APP_HOME_MAIN);
          return true;
        }
    );
  }

  Widget buildView(bool isLoading,bool isLoading3,bool isLoading1,bool isLoading2){
    return isLoading?Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Loader()
      ],
    ):ListView(
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
                    text: OrderViewModel.booking.categoryName,
                    color: AppColors.WHITE,
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimen.TEXT_H1,
                  ),
                  Content(
                    padding: EdgeInsets.only(top: 10,left: 15,right: 15),
                    alignment: Alignment.centerLeft,
                    fontfamily: AppFont.FONT,
                    textHeight: 1.5,
                    text: 'Get lowest prices for ${OrderViewModel.booking.categoryName} in Madurai',
                    color: AppColors.WHITE_1,
                    fontWeight: FontWeight.w400,
                    fontSize: AppDimen.TEXT_SMALL,
                  ),
                ],
              ),
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.only(top: 250,left: 10,right: 10),
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BorderContainer(
                          radius: 4,
                          padding: EdgeInsets.only(left: 5,right: 5,top: 8,bottom: 8),
                          bgColor: AppColors.SUCCESS_COLOR,
                          child: Content(
                            width: 80,
                            text: OrderViewModel.booking.status,
                            color: AppColors.WHITE,
                            fontfamily: AppFont.FONT,
                            fontSize: AppDimen.TEXT_MINI,
                            fontWeight: FontWeight.w500,
                          )
                      ),
                      Content(
                        color:AppColors.GRAY,
                        text: 'Name',
                        alignment: Alignment.centerLeft,
                        textHeight: 2,
                        fontfamily: AppFont.FONT,
                        margin: EdgeInsets.only(top: 15),
                        fontWeight: FontWeight.w400,
                        fontSize: AppDimen.TEXT_SMALLEST,
                      ),
                      Content(
                        alignment: Alignment.centerLeft,
                        textHeight: 1.5,
                        margin: EdgeInsets.only(top: 5),
                        color:AppColors.BLACK,
                        text: OrderViewModel.booking.userName,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLER,
                      ),
                      Content(
                        color:AppColors.GRAY,
                        text: 'Phone Number',
                        margin: EdgeInsets.only(top: 15),
                        alignment: Alignment.centerLeft,
                        textHeight: 2,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w400,
                        fontSize: AppDimen.TEXT_SMALLEST,
                      ),
                      Content(
                        alignment: Alignment.centerLeft,
                        textHeight: 1.5,
                        margin: EdgeInsets.only(top: 5),
                        color:AppColors.BLACK,
                        text: OrderViewModel.booking.userPhone,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLER,
                      ),
                      Content(
                        color:AppColors.GRAY,
                        text: 'Service',
                        margin: EdgeInsets.only(top: 15),
                        alignment: Alignment.centerLeft,
                        textHeight: 2,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w400,
                        fontSize: AppDimen.TEXT_SMALLEST,
                      ),
                      Content(
                        alignment: Alignment.centerLeft,
                        textHeight: 1.5,
                        margin: EdgeInsets.only(top: 5),
                        color:AppColors.BLACK,
                        text: OrderViewModel.booking.name,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLER,
                      ),
                      Content(
                        margin: EdgeInsets.only(top: 15),
                        color:AppColors.GRAY,
                        text: 'Service Date',
                        alignment: Alignment.centerLeft,
                        textHeight: 2,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w400,
                        fontSize: AppDimen.TEXT_SMALLEST,
                      ),
                      Content(
                        alignment: Alignment.centerLeft,
                        textHeight: 1.5,
                        margin: EdgeInsets.only(top: 5),
                        color:AppColors.BLACK,
                        text: OrderViewModel.booking.date,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLER,
                      ),
                      Content(
                        margin: EdgeInsets.only(top: 15),
                        color:AppColors.GRAY,
                        text: 'Address',
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLEST,
                        alignment: Alignment.centerLeft,
                        textHeight: 2,
                      ),
                      Content(
                        color:AppColors.BLACK,
                        margin: EdgeInsets.only(top: 5),
                        text: OrderViewModel.booking.address,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLER,
                        alignment: Alignment.centerLeft,
                        textHeight: 1.5,
                      ),
                      Content(
                        margin: EdgeInsets.only(top: 15),
                        color:AppColors.GRAY,
                        text: 'Amount',
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLEST,
                        alignment: Alignment.centerLeft,
                        textHeight: 2,
                      ),
                      Content(
                        color:AppColors.BLACK,
                        text: '\u20B9 ${OrderViewModel.booking.totalPrice}',
                        margin: EdgeInsets.only(top: 5),
                        overflow: TextOverflow.ellipsis,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLER,
                        alignment: Alignment.centerLeft,
                        textHeight: 1.5,
                      ),
                      Content(
                        margin: EdgeInsets.only(top: 15),
                        color:AppColors.GRAY,
                        text: 'Payment Type',
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLEST,
                        alignment: Alignment.centerLeft,
                        textHeight: 2,
                      ),
                      Content(
                        color:AppColors.BLACK,
                        margin: EdgeInsets.only(top: 5),
                        text: OrderViewModel.booking.payMethod,
                        overflow: TextOverflow.ellipsis,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLER,
                        alignment: Alignment.centerLeft,
                        textHeight: 1.5,
                      ),
                      Visibility(
                          visible: additional=='ADDED',
                          child: Row(
                            children: [
                              Expanded(child: Content(
                                color:AppColors.BLACK,
                                margin: EdgeInsets.only(top: 5),
                                text: 'Additional Price',
                                overflow: TextOverflow.ellipsis,
                                fontfamily: AppFont.FONT,
                                fontWeight: FontWeight.w500,
                                fontSize: AppDimen.TEXT_SMALLER,
                                alignment: Alignment.centerLeft,
                                textHeight: 1.5,
                              ),),
                              Expanded(child: Content(
                                color:AppColors.BLACK,
                                margin: EdgeInsets.only(top: 5),
                                text: '\u20B9 ${OrderViewModel.booking.additionalPrice}',
                                overflow: TextOverflow.ellipsis,
                                fontfamily: AppFont.FONT,
                                fontWeight: FontWeight.w500,
                                fontSize: AppDimen.TEXT_SMALLER,
                                alignment: Alignment.centerLeft,
                                textHeight: 1.5,
                              ),),
                            ],
                          )
                      ),
                      Visibility(
                          visible: additional=='ADDED',
                          child: Row(
                            children: [
                              Expanded(child: Content(
                                color:AppColors.BLACK,
                                margin: EdgeInsets.only(top: 5),
                                text: 'Description',
                                overflow: TextOverflow.ellipsis,
                                fontfamily: AppFont.FONT,
                                fontWeight: FontWeight.w500,
                                fontSize: AppDimen.TEXT_SMALLER,
                                alignment: Alignment.centerLeft,
                                textHeight: 1.5,
                              ),),
                              Expanded(child: Content(
                                color:AppColors.BLACK,
                                margin: EdgeInsets.only(top: 5),
                                text: OrderViewModel.booking.additionalDesc,
                                overflow: TextOverflow.ellipsis,
                                fontfamily: AppFont.FONT,
                                fontWeight: FontWeight.w500,
                                fontSize: AppDimen.TEXT_SMALLER,
                                alignment: Alignment.centerLeft,
                                textHeight: 1.5,
                              ),),
                            ],
                          )
                      ),
                      Visibility(
                        visible: type=='PENDING',
                        child: BorderContainer(
                            radius: 4,
                            margin: EdgeInsets.only(left: 15,right: 15,top: 30),
                            padding: EdgeInsets.only(top: 5,bottom: 5),
                            bgColor: AppColors.SECONDARY_COLOR,
                            child: OnTapField(
                              child: isLoading1
                                  ?Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Loader(margin: EdgeInsets.all(0),)
                                ],
                              )
                                  :Content(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                text: 'APPROVE ORDER',
                                color: AppColors.WHITE,
                                fontfamily: AppFont.FONT,
                                fontSize: AppDimen.TEXT_SMALL,
                                fontWeight: FontWeight.w400,
                              ),
                              onTap: (){
                                OrderViewModel.load1 = true;
                                  bloc.add(ApproveOrder(categoryId: OrderViewModel.booking.id));
                              },
                            )
                        )
                      ),
                      Visibility(
                          visible: type!='COMPLETED' && additional=='ADD',
                          child: BorderContainer(
                              radius: 4,
                              margin: EdgeInsets.only(left: 15,right: 15,top: 30),
                              padding: EdgeInsets.only(top: 5,bottom: 5),
                              bgColor: AppColors.SECONDARY_COLOR,
                              child: OnTapField(
                                child: isLoading1
                                    ?Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Loader(margin: EdgeInsets.all(0),)
                                  ],
                                )
                                    :Content(
                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                  text: 'ADD ADDITIONAL CHARGE',
                                  color: AppColors.WHITE,
                                  fontfamily: AppFont.FONT,
                                  fontSize: AppDimen.TEXT_SMALL,
                                  fontWeight: FontWeight.w400,
                                ),
                                onTap: (){
                                  App().setNavigation(context, AppRoutes.APP_ADDITIONAL_CHARGE);
                                },
                              )
                          )
                      ),
                      Visibility(
                          visible: type!='COMPLETED' && additional=='ADDED',
                          child: BorderContainer(
                              radius: 4,
                              margin: EdgeInsets.only(left: 15,right: 15,top: 30),
                              padding: EdgeInsets.only(top: 5,bottom: 5),
                              bgColor: AppColors.SECONDARY_COLOR,
                              child: OnTapField(
                                child: isLoading1
                                    ?Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Loader(margin: EdgeInsets.all(0),)
                                  ],
                                )
                                    :Content(
                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                  text: 'REMOVE ADDITIONAL CHARGE',
                                  color: AppColors.WHITE,
                                  fontfamily: AppFont.FONT,
                                  fontSize: AppDimen.TEXT_SMALL,
                                  fontWeight: FontWeight.w400,
                                ),
                                onTap: (){
                                  OrderViewModel.load3 = true;
                                  bloc.add(RemoveAdditionalCharge(id: OrderViewModel.booking.additionalId));
                                },
                              )
                          )
                      ),
                      Visibility(
                        visible: type=='APPROVED',
                        child: BorderContainer(
                            radius: 4,
                            margin: EdgeInsets.only(left: 15,right: 15,top: 30),
                            padding: EdgeInsets.only(top: 5,bottom: 5),
                            bgColor: AppColors.SECONDARY_COLOR,
                            child: OnTapField(
                              child: isLoading1
                                  ?Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Loader(margin: EdgeInsets.all(0),)
                                ],
                              )
                                  :Content(
                                padding: EdgeInsets.only(top: 10,bottom: 10),
                                text: 'ORDER COMPLETED',
                                color: AppColors.WHITE,
                                fontfamily: AppFont.FONT,
                                fontSize: AppDimen.TEXT_SMALL,
                                fontWeight: FontWeight.w400,
                              ),
                              onTap: (){
                                OrderViewModel.load1 = true;
                                 bloc.add(CompleteOrder(categoryId: OrderViewModel.booking.id));
                              },
                            )
                        )
                      ),
                      Visibility(
                          visible: payType=='PENDING',
                          child:
                          BorderContainer(
                              radius: 4,
                              margin: EdgeInsets.only(left: 15,right: 15,top: 30),
                              padding: EdgeInsets.only(top: 5,bottom: 5),
                              bgColor: AppColors.SECONDARY_COLOR,
                              child: OnTapField(
                                child: isLoading2
                                    ?Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Loader(margin: EdgeInsets.all(0),)
                                  ],
                                )
                                    :Content(
                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                  text: 'PAYMENT RECEIVED',
                                  color: AppColors.WHITE,
                                  fontfamily: AppFont.FONT,
                                  fontSize: AppDimen.TEXT_SMALL,
                                  fontWeight: FontWeight.w400,
                                ),
                                onTap: (){
                                  OrderViewModel.load2 = true;
                                  bloc.add(UpdatePaymentStatus(orderId:OrderViewModel.orderId,paymentId: '',method: 'CASH'));
                                },
                              )
                          )
                      )
                    ],
                  )
              ),
            )
          ],
        ),
      ],
    );
  }
}

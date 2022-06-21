import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/image_container.dart';
import 'package:inses_app/comps/image_view.dart';
import 'package:inses_app/comps/line.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/model/order.dart';
import 'package:inses_app/network/app_api_client.dart';
import 'package:inses_app/network/app_repository.dart';
import 'package:inses_app/network/bloc/network_bloc.dart';
import 'package:inses_app/network/bloc/network_event.dart';
import 'package:inses_app/network/bloc/network_state.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/view_models/order_view_model.dart';
import 'package:inses_app/view_models/profile_view_model.dart';
import 'package:inses_app/widgets/error_item.dart';
import 'package:inses_app/widgets/loader.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ServiceSummary extends StatefulWidget {

  @override
  _ServiceSummaryState createState() => _ServiceSummaryState();
}

class _ServiceSummaryState extends State<ServiceSummary> {
  static const platform = const MethodChannel("razorpay_flutter");
  int items = OrderViewModel.noOfService;
  AlertDialog alert;
  NetworkBloc bloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));
  OrderViewModel viewModel;

  Razorpay _razorpay;

  @override
  void initState() {
    viewModel = OrderViewModel(App());
    bloc = NetworkBloc(appRepository: appRepository);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App().appBarBack(
        context,
        'Summary of your service',
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: OnTapField(
                    child: BorderContainer(
                      padding: EdgeInsets.all(20),
                      bgColor: AppColors.PRIMARY_COLOR,
                      radius: 7,
                      child: Content(
                        color:AppColors.WHITE,
                        text: 'BOOK NOW',
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALL,
                      ),
                    ),
                    onTap:(){
                      bloc.add(BookService(order: Order(
                        date: OrderViewModel.date,
                        start_time:OrderViewModel.startTime,
                        end_time: OrderViewModel.endTime,
                        address: OrderViewModel.address,
                        service_id: OrderViewModel.serviceId,
                        quantity: OrderViewModel.noOfService
                      )));
                    }
                )
            )
          ],
        ),
      ),
      body: BlocBuilder<NetworkBloc,NetworkState>(
        bloc: bloc,
        builder: (context,state){
          if(state is Initial || state is Loading || state is ServiceBooked || state is PaymentStatusUpdated){

            if(state is Loading){
              Future.delayed(Duration.zero, () async {
                showDialogue();
              });
            }else if(state is ServiceBooked){
              Navigator.of(context).pop();
              Future.delayed(Duration.zero, () async {
                showConfirmDialogue();
              });
            }else if(state is PaymentStatusUpdated){
              Navigator.of(context).pop();
              Future.delayed(Duration.zero, () async {
                showSuccessDialogue();
              });
            }

            return buildView();
          }else if(state is Error){
            return ErrorItem();
          }else{
            return Container();
          }
        },
      )
    );
  }

  Widget buildView(){
    return ListView(
      children: [
        Container(
          color: AppColors.SECONDARY_COLOR,
            padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageView(
                width: 100,
                asset: 'logo-h2.png',
              ),
            ],
          )
        ),
        Container(
          color: AppColors.SECONDARY_COLOR,
          padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 20),
          child:  Row(
            children: [
              Expanded(
                  child: Column(
                    children: [
                      Content(
                        color:AppColors.WHITE_3,
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
                        color:AppColors.WHITE,
                        overflow: TextOverflow.ellipsis,
                        text: '${OrderViewModel.date}, ${OrderViewModel.time}',
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLER,
                      ),
                    ],
                  )
              ),
              Line(
                width: 1,
                height: 70,
                color: AppColors.WHITE_1,
                margin: EdgeInsets.only(right: 10, left: 10),
              ),
              Expanded(
                  child: Column(
                    children: [
                      Content(
                        color:AppColors.WHITE_2,
                        text: 'Address',
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLEST,
                        alignment: Alignment.centerLeft,
                        textHeight: 2,
                      ),
                      Content(
                        color:AppColors.WHITE,
                        text: '${OrderViewModel.address}',
                        overflow: TextOverflow.ellipsis,
                        fontfamily: AppFont.FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimen.TEXT_SMALLER,
                        alignment: Alignment.centerLeft,
                        textHeight: 1.5,
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
        Line(
          width: double.infinity,
          height: 5,
          color: AppColors.WHITE_1,
          margin: EdgeInsets.only(top: 0, bottom: 10),
        ),
        Content(
          margin: EdgeInsets.only(top: 10, bottom: 10,left: 15,right: 15),
          color:AppColors.BLACK,
          text: 'My Requirements',
          fontfamily: AppFont.FONT,
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.w500,
          fontSize: AppDimen.TEXT_SMALL,
        ),
        // Content(
        //   margin: EdgeInsets.only(top: 20, bottom: 10,left: 15,right: 15),
        //   color:AppColors.BLACK,
        //   text: 'Convenience Charges',
        //   fontfamily: AppFont.FONT,
        //   alignment: Alignment.centerLeft,
        //   fontWeight: FontWeight.w500,
        //   fontSize: AppDimen.TEXT_SMALLEST,
        // ),
        // Content(
        //   margin: EdgeInsets.only(top: 0, bottom: 10,left: 15,right: 15),
        //   color:AppColors.BLACK,
        //   text: '\u20B9 ${OrderViewModel.totalPrice}',
        //   alignment: Alignment.centerLeft,
        //   fontfamily: AppFont.FONT,
        //   fontWeight: FontWeight.w500,
        //   fontSize: AppDimen.TEXT_SMALL,
        // ),
        // Line(
        //   width: double.infinity,
        //   height: 2,
        //   color: AppColors.WHITE_1,
        //   margin: EdgeInsets.only(top: 20, bottom: 10),
        // ),
        Container(
          margin: EdgeInsets.only(left: 15,right: 15,top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageContainer(
                margin: EdgeInsets.only(right: 15,left: 5),
                radius: 5,
                height: 50,
                width: 50,
                url: OrderViewModel.serviceIcon,
              ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Content(
                        padding: EdgeInsets.only(bottom: 12),
                        text: '${OrderViewModel.service}',
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.BLACK,
                        alignment: Alignment.centerLeft,
                        fontfamily: AppFont.FONT,
                        fontSize: AppDimen.TEXT_SMALL,
                        fontWeight: FontWeight.w500,
                      ),
                      Content(
                        text: '\u20B9 ${OrderViewModel.totalPrice}',
                        color: AppColors.BLACK,
                        alignment: Alignment.centerLeft,
                        fontfamily: AppFont.FONT,
                        fontSize: AppDimen.TEXT_SMALL,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  )
              ),
              BorderContainer(
                bgColor: AppColors.SECONDARY_COLOR,
                padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                radius: 4,
                child: Content(
                  color:AppColors.WHITE,
                  text: OrderViewModel.noOfService.toString(),
                  fontfamily: AppFont.FONT,
                  fontWeight: FontWeight.w500,
                  fontSize: AppDimen.TEXT_SMALL,
                ),
              ),
            ],
          ),
        ),
        Line(
          width: double.infinity,
          height: 2,
          color: AppColors.WHITE_1,
          margin: EdgeInsets.only(top: 20, bottom: 10),
        ),
        BorderContainer(
          bgColor: AppColors.WHITE_2,
          margin: EdgeInsets.only(top: 20, bottom: 10,left: 15,right: 15),
          padding: EdgeInsets.only(top: 10, bottom: 10,left: 15,right: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_outline,color: AppColors.SUCCESS_COLOR,size: 20,),
              Flexible(
                  child: Content(
                    margin: EdgeInsets.only(left: 10),
                    text: 'Free Cancellation and Date Change at anytime',
                    color: AppColors.BLACK_3,
                    alignment: Alignment.centerLeft,
                    fontfamily: AppFont.FONT,
                    fontSize: AppDimen.TEXT_SMALLEST,
                    fontWeight: FontWeight.w500,
                  ),
              )
            ],
          ),
        )
      ],
    );
  }

  void openCheckout() async {
    var options = {
      "key": "rzp_live_PIb7s06FK67MLz",
      "amount": "${OrderViewModel.totalPrice*100}",
      "currency": "INR",
      "name": "INSES",
      "description": "${OrderViewModel.service}",
      "image": "https://inses.in/wp-content/uploads/2021/03/inses-logo.png",
      // "handler": (response) {},
      "prefill": {
        "name": "${ProfileViewModel.name}",
        // "email": "gaurav.kumar@example.com",
        "contact": "${ProfileViewModel.phone}"
      },
      'external': {
        'wallets': ['paytm']
      },
      "notes": {
        "address": "${OrderViewModel.address}"
      },
      "theme": {
        "color": "#0E4472"
      },
      // "modal": {
      //   "ondismiss": () {
      //   }
      // }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please try again later',style: TextStyle(fontSize: AppDimen.TEXT_SMALL))));
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response.paymentId);
    bloc.add(UpdatePaymentStatus(orderId:OrderViewModel.orderId,paymentId: response.paymentId,method: 'CARD'));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showFailureDialogue();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment Failed! Our experts will reach you soon',style: TextStyle(fontSize: AppDimen.TEXT_SMALL))));
  }


  Widget showDialogue(){
    alert = AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Loader()
        ],
      )
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: (){},
        child:alert);
      },
    );
  }

  Widget showConfirmDialogue(){
    alert = AlertDialog(
        content: SizedBox(
          height: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Content(
                margin: EdgeInsets.only(left: 10),
                text: 'Successfully Booked Your Service',
                color: AppColors.BLACK,
                alignment: Alignment.centerLeft,
                fontfamily: AppFont.FONT,
                fontSize: AppDimen.TEXT_SMALL,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 20,
              ),
              Icon(Icons.check_circle_outline,color: AppColors.SUCCESS_COLOR,size: 100,),
              SizedBox(
                height: 20,
              ),
              OnTapField(
                  child: BorderContainer(
                    bgColor: AppColors.SECONDARY_COLOR,
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    radius: 4,
                    child: Content(
                      color:AppColors.WHITE,
                      text: 'PAY NOW',
                      fontfamily: AppFont.FONT,
                      fontWeight: FontWeight.w500,
                      fontSize: AppDimen.TEXT_SMALL,
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).pop();
                    openCheckout();
                  }
              ),
              SizedBox(
                height: 20,
              ),
              OnTapField(
                  child: BorderContainer(
                    borderColor: AppColors.WHITE_1,
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    radius: 4,
                    child: Content(
                      color:AppColors.BLACK,
                      text: 'ON TIME CASH',
                      fontfamily: AppFont.FONT,
                      fontWeight: FontWeight.w500,
                      fontSize: AppDimen.TEXT_SMALL,
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).pop();
                    App().setNavigation(context, AppRoutes.APP_HOME_MAIN);
                  }
              )
            ],
          ),
        )
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: (){},
        child:alert);
      },
    );
  }

  Widget showSuccessDialogue(){
    alert = AlertDialog(
        content: SizedBox(
          height: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Content(
                margin: EdgeInsets.only(left: 10),
                text: 'Payment Successful!',
                color: AppColors.BLACK,
                alignment: Alignment.centerLeft,
                fontfamily: AppFont.FONT,
                fontSize: AppDimen.TEXT_H7,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 20,
              ),
              Icon(Icons.check_circle_outline,color: AppColors.SUCCESS_COLOR,size: 100,),
              SizedBox(
                height: 20,
              ),
              Content(
                margin: EdgeInsets.only(left: 10),
                text: 'Our Experts will reach you soon!',
                color: AppColors.BLACK,
                alignment: Alignment.centerLeft,
                fontfamily: AppFont.FONT,
                fontSize: AppDimen.TEXT_SMALL,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 20,
              ),
              OnTapField(
                  child: BorderContainer(
                    bgColor: AppColors.SECONDARY_COLOR,
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    radius: 4,
                    child: Content(
                      color:AppColors.WHITE,
                      text: 'OK',
                      fontfamily: AppFont.FONT,
                      fontWeight: FontWeight.w500,
                      fontSize: AppDimen.TEXT_SMALL,
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).pop();
                    App().setNavigation(context, AppRoutes.APP_HOME_MAIN);
                  }
              ),
            ],
          ),
        )
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: (){},
        child:alert);
      },
    );
  }

  Widget showFailureDialogue(){
    alert = AlertDialog(
        content: SizedBox(
          height: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Content(
                margin: EdgeInsets.only(left: 10),
                text: 'Payment Failed!',
                color: AppColors.BLACK,
                alignment: Alignment.center,
                fontfamily: AppFont.FONT,
                fontSize: AppDimen.TEXT_H7,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 20,
              ),
              Icon(Icons.close,color: AppColors.WARNING_COLOR,size: 100,),
              SizedBox(
                height: 20,
              ),
              Content(
                margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                text: 'Use On Time Case!',
                color: AppColors.BLACK,
                alignment: Alignment.center,
                fontfamily: AppFont.FONT,
                fontSize: AppDimen.TEXT_SMALL,
                fontWeight: FontWeight.w500,
              ),
              OnTapField(
                  child: BorderContainer(
                    bgColor: AppColors.SECONDARY_COLOR,
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    radius: 4,
                    child: Content(
                      color:AppColors.WHITE,
                      text: 'OK',
                      fontfamily: AppFont.FONT,
                      fontWeight: FontWeight.w500,
                      fontSize: AppDimen.TEXT_SMALL,
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).pop();
                    App().setNavigation(context, AppRoutes.APP_HOME_MAIN);
                  }
              ),
            ],
          ),
        )
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: (){},
        child:alert);
      },
    );
  }

  @override
  void dispose() {
    bloc.close();
    _razorpay.clear();
    super.dispose();
  }

}

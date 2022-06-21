import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/image_view.dart';
import 'package:inses_app/comps/primary_button.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/network/app_api_client.dart';
import 'package:inses_app/network/app_repository.dart';
import 'package:inses_app/network/bloc/network_bloc.dart';
import 'package:inses_app/network/bloc/network_event.dart' as ev;
import 'package:inses_app/network/bloc/network_state.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inses_app/view_models/edit_view_model.dart';
import 'package:inses_app/view_models/order_view_model.dart';
import 'package:inses_app/widgets/error_item.dart';
import 'package:inses_app/widgets/grey_micro.dart';
import 'package:inses_app/widgets/input_item.dart';
import 'package:inses_app/widgets/loader.dart';
import 'package:inses_app/widgets/sub_title.dart';

class AddAdditionalCharge extends StatefulWidget {

  @override
  _AddAdditionalChargeState createState() => _AddAdditionalChargeState();
}

class _AddAdditionalChargeState extends State<AddAdditionalCharge> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EditViewModel _viewmodel;
  NetworkBloc editBloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));

  @override
  void initState() {
    _viewmodel = EditViewModel(App());
    editBloc = NetworkBloc(appRepository: appRepository);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
        appBar: App().appBarBack(
          context,
          'Add Additional Charge',
        ),
        body:Form(
            key: _formKey,
            child:BlocBuilder<NetworkBloc,NetworkState>(
              bloc: editBloc,
              builder: (context,state){
                if(state is Empty || state is Loading){
                  return buildView(true);
                }else if(state is Error){
                  return ErrorItem();
                }else if(state is Initial || state is Added){
                  if(state is Added){
                    Future.delayed(Duration.zero, () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Wrap(
                                children: [
                                  Content(
                                    padding: EdgeInsets.only(top: 5,bottom: 5),
                                    text: 'Additional Charge is Added',
                                    fontSize: AppDimen.TEXT_SMALL,
                                    fontWeight: FontWeight.w400,
                                    fontfamily: AppFont.FONT,
                                  ),
                                ],
                              )
                          )
                      );
                    }
                    );
                    App().setNavigation(context, AppRoutes.APP_UPDATE_BOOKING_STATUS);
                  }
                  return buildView(false);
                }else{
                  return Container();
                }
              },
            )
        )
    ), onWillPop: ()async{
      App().setNavigation(context, AppRoutes.APP_UPDATE_BOOKING_STATUS);
      return true;
    });
  }

  Widget buildView(bool isLoading){
    return ListView(
        children: [
          SubTitle(
            margin: EdgeInsets.only(left: 20,right: 20,top: 10),
            text: 'Service',
          ),
          GreyMicro(
            text: 'Book your services at any time with low cost',
            alignment: Alignment.centerLeft,
          ),
          InputItem(
            controller: _viewmodel.nameController,
            autoFocus: true,
            prefixIcon: Icon(Icons.cleaning_services_outlined),
            margin: EdgeInsets.only(top: 30,left: 20,right: 20),
            text: 'Description',
            emptyError: 'Desc should not be empty',
            isObscurred: false,
          ),
          InputItem(
            controller: _viewmodel.priceController,
            autoFocus: false,
            prefixIcon: Icon(Icons.monetization_on_outlined),
            margin: EdgeInsets.only(top: 30,left: 20,right: 20),
            text: 'Amount',
            emptyError: 'amount should not be empty',
            inputType: TextInputType.number,
            patternError: 'Invalid price',
            regExp:(RegExp(r'[0-9]')),
            isObscurred: false,
          ),
          BorderContainer(
              radius: 4,
              margin: EdgeInsets.only(left: 15,right: 15,top: 30),
              padding: EdgeInsets.only(top: 5,bottom: 5),
              bgColor: AppColors.SECONDARY_COLOR,
              child: OnTapField(
                child: isLoading
                    ?Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Loader(margin: EdgeInsets.all(0),)
                  ],
                )
                    :Content(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  text: 'ADD',
                  color: AppColors.WHITE,
                  fontfamily: AppFont.FONT,
                  fontSize: AppDimen.TEXT_SMALL,
                  fontWeight: FontWeight.w400,
                ),
                onTap: (){
                  if(_formKey.currentState.validate()) {
                    editBloc.add(
                        ev.AddAdditionalCharge(
                          price: int.parse(_viewmodel.priceController.text),
                          desc: _viewmodel.nameController.text,
                          orderId: OrderViewModel.booking.id
                        )
                    );
                  }
                },
              )
          )
        ]
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/input_field.dart';
import 'package:inses_app/comps/line.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/model/area.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/view_models/order_view_model.dart';
import 'package:inses_app/view_models/profile_view_model.dart';
import 'package:inses_app/widgets/input_item_two.dart';
import 'package:inses_app/widgets/location_dialogue.dart';
import 'package:inses_app/widgets/mini_title.dart';

class AddressSelect extends StatefulWidget {

  @override
  _AddressSelectState createState() => _AddressSelectState();
}

class _AddressSelectState extends State<AddressSelect> with AutomaticKeepAliveClientMixin{

  Completer<GoogleMapController> _controller;
  CameraPosition _kGooglePlex;
  StreamController<Position> mapController;
  StreamController<String> addressController;
  List<AreaModel> areas;
  OrderViewModel viewModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _controller = Completer();
    mapController = StreamController();
    addressController = StreamController();
    viewModel = OrderViewModel(App());
    viewModel.addressController.text = ProfileViewModel.address.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App().appBarBack(
          context,
          'Your Address',
          child: OnTapField(
              child: Icon(Icons.location_on,color: AppColors.PRIMARY_COLOR,),
              onTap: (){}
          )
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            OnTapField(
                child: BorderContainer(
                  bgColor: AppColors.SECONDARY_COLOR,
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                  radius: 4,
                  child: Content(
                    color:AppColors.WHITE,
                    text: 'Continue',
                    fontfamily: AppFont.FONT,
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimen.TEXT_SMALL,
                  ),
                ),
                onTap:(){
                    if(_formKey.currentState.validate()) {
                      OrderViewModel.address = viewModel.addressController.text;
                      App().setNavigation(context, AppRoutes.APP_ORDER_FLOW_4);
                    }
                  }
            )
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child:Container(
          child: buildView(),
        )
      ),
    );
  }

  Widget buildView(){
    return ListView(
      children: [
        Container(
          height: 180,
          child: StreamBuilder(
            stream: mapController.stream,
            initialData: Position(latitude: 9.925201,longitude: 78.119774),
            builder: (context,AsyncSnapshot shot){
              _kGooglePlex = CameraPosition(
                  target: LatLng(shot.data.latitude, shot.data.longitude),
                  zoom: 8.4746
              );
              List<Marker> markers = [Marker(
                markerId: MarkerId('Area'),
                position: LatLng(shot.data.latitude,shot.data.longitude),
                infoWindow: InfoWindow(title: 'address', snippet: '*'),
                onTap: () {

                },
              )];
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: Set<Marker>.of(markers),
              );
            },
          )
        ),
        Line(
          width: double.infinity,
          height: 5,
          color: AppColors.WHITE_1,
          margin: EdgeInsets.only(bottom: 10),
        ),
        MiniTitle(
          text: 'Address',
        ),
        InputField(
            text: 'Enter your address',
            isShadow: false,
            errorMaxLines: 3,
            autoFocus: false,
            margin: EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 20),
            controller: viewModel.addressController,
            emptyErrorText: 'Address Should not be empty',
            enabledBorderColor: AppColors.WHITE_1,
            enabledBorderWidth: 1.0,
            focusedBorderColor: AppColors.SECONDARY_COLOR,
            hintColor: AppColors.GRAY_2,
            focusedBorderWidth: 1.0,
            inputType: TextInputType.multiline,
            bgColor: AppColors.WHITE,
            prefixIcon: Padding(
              padding: EdgeInsets.only(bottom: 70),
              child: Icon(Icons.home),
            ),
            hoverColor: AppColors.SECONDARY_COLOR,
            radius: 3,
            height: 120,
            minLine: 100,
            maxLine: 100,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            color: AppColors.BLACK,
            fontfamily: AppFont.FONT,
            fontWeight: FontWeight.w500,
            fontSize: AppDimen.TEXT_SMALLER,
            contentPadding: EdgeInsets.only(
                top: 15, bottom: 15, left: 10, right: 10),
            width: 400),
        OnTapField(child: BorderContainer(
          bgColor: AppColors.WHITE_2,
          margin: EdgeInsets.only(top: 20, bottom: 10,left: 15,right: 15),
          padding: EdgeInsets.only(top: 10, bottom: 10,left: 15,right: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on,color: AppColors.SUCCESS_COLOR,size: 20,),
              Flexible(
                child: Content(
                  margin: EdgeInsets.only(left: 10),
                  text: 'Add Current Location',
                  color: AppColors.BLACK_3,
                  alignment: Alignment.centerLeft,
                  fontfamily: AppFont.FONT,
                  fontSize: AppDimen.TEXT_SMALLEST,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ), onTap: showDialogue),
        Line(
          width: double.infinity,
          height: 1,
          color: AppColors.WHITE_1,
          margin: EdgeInsets.only(bottom: 10),
        ),
      ],
    );
  }

  Widget saveItem(IconData iconData,String title,bool isClicked){
    return Container(
        width: 110,
        child: BorderContainer(
          borderColor: isClicked?AppColors.SECONDARY_COLOR:AppColors.WHITE_1,
          radius: 5,
          padding: EdgeInsets.all(15),
          bgColor: isClicked?AppColors.WHITE:AppColors.WHITE_1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconData,size: 15,),
                Content(
                  padding: EdgeInsets.only(left: 5),
                  alignment: Alignment.center,
                  text: title,
                  fontfamily: AppFont.FONT,
                  color: AppColors.BLACK,
                  fontWeight: FontWeight.w500,
                  fontSize: AppDimen.TEXT_SMALLEST,
                )
          ],
        ),
      )
    );
  }

  showDialogue(){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return LocationDialogue(
              title: "current location",
              description: "Add your current location address",
              text: "Yes",
              onPressed:(){
                viewModel.getPosition();
                Navigator.of(context).pop();
              }
          );
        }
    );
  }

}

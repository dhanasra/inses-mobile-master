
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:inses_app/network/bloc/network_event.dart';
import 'package:inses_app/network/bloc/network_state.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/view_models/edit_view_model.dart';
import 'package:inses_app/view_models/home_view_model.dart';
import 'package:inses_app/widgets/error_item.dart';
import 'package:inses_app/widgets/grey_micro.dart';
import 'package:inses_app/widgets/input_item.dart';
import 'package:inses_app/widgets/loader.dart';
import 'package:inses_app/widgets/sub_title.dart';

class AddService extends StatefulWidget {

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  EditViewModel _viewmodel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool picked1 = false;
  bool picked2 = false;
  String path1;
  String path2;
  NetworkBloc editBloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));

  @override
  void initState() {
    _viewmodel = EditViewModel(App());
    picked1 = false;
    picked2 = false;
    editBloc = NetworkBloc(appRepository: appRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: App().appBarBack(
          context,
          'Add Service',
        ),
        body:Form(
            key: _formKey,
            child:BlocBuilder<NetworkBloc,NetworkState>(
              bloc: editBloc,
              builder: (context,state){
                if(state is Empty || state is Loading){
                  return buildView(true);
                }else if(state is Error){
                  Future.delayed(Duration.zero, () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Wrap(
                              children: [
                                Content(
                                  padding: EdgeInsets.only(top: 5,bottom: 5),
                                  text: state.error??(state.error.isNotEmpty?state.error:"Error Occured"),
                                  fontSize: AppDimen.TEXT_SMALL,
                                  fontWeight: FontWeight.w400,
                                  fontfamily: AppFont.FONT,
                                ),
                              ],
                            )
                        )
                    );
                  });
                  return buildView(false);
                }else if(state is Initial || state is Success){
                  if(state is Success){
                    Future.delayed(Duration.zero, () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Wrap(
                                children: [
                                  Content(
                                    padding: EdgeInsets.only(top: 5,bottom: 5),
                                    text: 'Service is updated successfully',
                                    fontSize: AppDimen.TEXT_SMALL,
                                    fontWeight: FontWeight.w400,
                                    fontfamily: AppFont.FONT,
                                  ),
                                ],
                              )
                          )
                      );
                      App().setNavigation(context, AppRoutes.APP_HOME_MAIN);
                    });
                  }
                  return buildView(false);
                }else{
                  return Container();
                }
              },
            )
        )
    );
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
            text: _viewmodel.nameController.text,
            emptyError: 'Name should not be empty',
            isObscurred: false,
          ),
          InputItem(
            controller: _viewmodel.priceController,
            autoFocus: false,
            prefixIcon: Icon(Icons.monetization_on_outlined),
            margin: EdgeInsets.only(top: 30,left: 20,right: 20),
            text: _viewmodel.priceController.text,
            emptyError: 'price should not be empty',
            inputType: TextInputType.number,
            patternError: 'Invalid price',
            regExp:(RegExp(r'[0-9]')),
            isObscurred: false,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  picked1 ?
                  BorderContainer(
                      margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                      borderColor: AppColors.WHITE_1,
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.file(
                            File(path1)
                        ),
                      )
                  ):
                  BorderContainer(
                    margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                    borderColor: AppColors.WHITE_1,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      width: 120,
                      height: 120,
                    ),
                  ),
                  OnTapField(
                      child: Container(
                        margin: EdgeInsets.only(top: 107,left: 20,right: 20),
                        child: OnTapField(
                            child: Content(
                              width: 122,
                              padding: EdgeInsets.only(top: 10,bottom: 10),
                              bgColor: AppColors.TRANSPARANT_3,
                              text: 'Edit',
                              color: AppColors.WHITE,
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                            ),
                            onTap: ()async{
                              PickedFile file = await ImagePicker().getImage(
                                  source: ImageSource.gallery);
                              EditViewModel.icon = File(file.path);
                              setState(() {
                                path1 = file.path;
                                picked1 = true;
                              });
                            }
                        ),
                      ),
                      onTap: (){

                      }
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  picked2 ?
                  BorderContainer(
                      margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                      borderColor: AppColors.WHITE_1,
                      child: SizedBox(
                        width: 220,
                        height: 120,
                        child: Image.file(
                            File(path2)
                        ),
                      )
                  ):
                  BorderContainer(
                    margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                    borderColor: AppColors.WHITE_1,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      width: 220,
                      height: 120,
                    ),
                  ),
                  OnTapField(
                      child: Container(
                        margin: EdgeInsets.only(top: 107,left: 20,right: 20),
                        child: OnTapField(
                            child: Content(
                              width: 222,
                              padding: EdgeInsets.only(top: 10,bottom: 10),
                              bgColor: AppColors.TRANSPARANT_3,
                              text: 'Edit',
                              color: AppColors.WHITE,
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                            ),
                            onTap: ()async{
                              PickedFile file = await ImagePicker().getImage(
                                  source: ImageSource.gallery);
                              EditViewModel.image = File(file.path);
                              setState(() {
                                path2 = file.path;
                                picked2 = true;
                              });
                            }
                        ),
                      ),
                      onTap: (){

                      }
                  )
                ],
              )
            ],
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
                    if (picked1 && picked2) {
                      editBloc.add(
                          AddServiceEvent(
                              categoryId: EditViewModel.category.id,
                              name: _viewmodel.nameController.text,
                              price: int.parse(_viewmodel.priceController.text),
                              icon: picked1 ? EditViewModel.icon : null,
                              image: picked2 ? EditViewModel.image : null
                          )
                      );
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Wrap(
                              children: [
                                Content(
                                  padding: EdgeInsets.only(top: 5,bottom: 5),
                                  text: ("Select Image"),
                                  fontSize: AppDimen.TEXT_SMALL,
                                  fontWeight: FontWeight.w400,
                                  fontfamily: AppFont.FONT,
                                ),
                              ],
                            )
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/network/app_api_client.dart';
import 'package:inses_app/network/app_repository.dart';
import 'package:inses_app/network/bloc/network_bloc.dart';
import 'package:inses_app/network/bloc/network_event.dart';
import 'package:inses_app/network/bloc/network_state.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/view_models/profile_view_model.dart';
import 'package:inses_app/widgets/error_item.dart';
import 'package:inses_app/widgets/input_item.dart';
import 'package:inses_app/widgets/loader.dart';
import 'package:inses_app/widgets/mini_title.dart';

class PasswordSettings extends StatefulWidget {

  @override
  _PasswordSettingsState createState() => _PasswordSettingsState();
}

class _PasswordSettingsState extends State<PasswordSettings> {
  NetworkBloc bloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ProfileViewModel(App());
    viewModel.passwordController.text = "";
    viewModel.oldpasswordController.text = "";
    bloc = NetworkBloc(appRepository: appRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: App().appBarBack(
          context,
          'Settings',
        ),
        body: Form(
            key: _formKey,
            child:BlocBuilder<NetworkBloc,NetworkState>(
              bloc: bloc,
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
                                  text: 'Old Password is not correct',
                                  fontSize: AppDimen.TEXT_SMALL,
                                  fontWeight: FontWeight.w400,
                                  fontfamily: AppFont.FONT,
                                ),
                              ],
                            )
                        )
                    );
                  });
                  viewModel.oldpasswordController.text='';
                  viewModel.phoneController.text = '';
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
                                    text: 'Password is updated successfully',
                                    fontSize: AppDimen.TEXT_SMALL,
                                    fontWeight: FontWeight.w400,
                                    fontfamily: AppFont.FONT,
                                  ),
                                ],
                              )
                          )
                      );
                    });
                  }
                  viewModel.phoneController.text = '';
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
        MiniTitle(
          text: 'Update Account Password',
        ),
        InputItem(
          focusNode: viewModel.oldpasswordFocus,
          autoFocus: false,
          controller: viewModel.oldpasswordController,
          prefixIcon: Icon(Icons.lock),
          margin: EdgeInsets.only(top: 20,left: 15,right: 15),
          text: 'Old Password',
          emptyError: 'Password should not be empty',
          lengthError: 'Password length should greater than 5',
          minLength: 6,
          isObscurred: true,
        ),
        InputItem(
          focusNode: viewModel.passwordFocus,
          autoFocus: false,
          controller: viewModel.passwordController,
          prefixIcon: Icon(Icons.lock),
          margin: EdgeInsets.only(top: 20,left: 15,right: 15),
          text: 'New Password',
          emptyError: 'Password should not be empty',
          lengthError: 'Password length should greater than 5',
          minLength: 6,
          isObscurred: true,
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
                text: 'UPDATE',
                color: AppColors.WHITE,
                fontfamily: AppFont.FONT,
                fontSize: AppDimen.TEXT_SMALL,
                fontWeight: FontWeight.w400,
              ),
              onTap: (){
                if(_formKey.currentState.validate()) {
                  bloc.add(UpdatePassword(old:viewModel.oldpasswordController.text,password: viewModel.passwordController.text));
                }
              },
            )
        )
      ],
    );
  }
}

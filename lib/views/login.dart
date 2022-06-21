import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/image_view.dart';
import 'package:inses_app/comps/primary_button.dart';
import 'package:inses_app/network/app_api_client.dart';
import 'package:inses_app/network/app_repository.dart';
import 'package:inses_app/network/bloc/network_bloc.dart';
import 'package:inses_app/network/bloc/network_event.dart';
import 'package:inses_app/network/bloc/network_state.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/view_models/register_view_model.dart';
import 'package:inses_app/widgets/double_color_button.dart';
import 'package:inses_app/widgets/grey_micro.dart';
import 'package:inses_app/widgets/grey_mini.dart';
import 'package:inses_app/widgets/input_item.dart';
import 'package:inses_app/widgets/or_item.dart';
import 'package:inses_app/widgets/sub_title.dart';
import 'package:line_icons/line_icons.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  RegisterViewModel _viewmodel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  NetworkBloc bloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));


  @override
  void initState() {
    _viewmodel = RegisterViewModel(App());
    bloc = NetworkBloc(appRepository: appRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<NetworkBloc,NetworkState>(
        bloc: bloc,
        builder: (context,state){
          if(state is LoginSuccess){
            print("success");
            if(state.id=="1") {
              App().setNavigation(context, AppRoutes.APP_HOME_MAIN);
            }else{
              App().setNavigation(context, AppRoutes.APP_NAME_FIELDS);
            }
          }else if(state is LoginError){
            print("error");
            if(state.error==""){

            }else{
              Future.delayed(Duration.zero, () async {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Wrap(
                          children: [
                            Content(
                              padding: EdgeInsets.only(top: 5,bottom: 5),
                              text: state.error,
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
          }
          return Container(
              color: AppColors.WHITE,
              child:  Form(
                key: _formKey,
                child: buildView(),
              )
          );
        },
      )
    );
  }

  Widget buildView(){
    return ListView(
      children: [
        ImageView(
          margin: EdgeInsets.only(left: 20,right: 20,top: 40),
          alignment: Alignment.centerLeft,
          width: 70,asset: 'logo-h2.png',
          height: 40,
        ),
        SubTitle(
          margin: EdgeInsets.only(left: 20,right: 20,top: 10),
          text: 'Login Your Account',
        ),
        GreyMicro(
          text: 'Book your services at any time with low cost',
          alignment: Alignment.centerLeft,
        ),
        InputItem(
          focusNode: _viewmodel.phoneFocus,
          controller: _viewmodel.phoneController,
          prefixIcon: Icon(Icons.phone),
          autoFocus: true,
          margin: EdgeInsets.only(top: 20,left: 20,right: 20),
          text: 'Phone number',
          emptyError: 'Phone number should not be empty',
          lengthError: 'Enter a valid phone number',
          patternError: 'Enter a valid phone number',
          minLength: 10,
          maxLength: 10,
          inputType: TextInputType.phone,
          isObscurred: false,
          regExp:(RegExp(r'[0-9]')),
        ),
        InputItem(
          focusNode: _viewmodel.passwordFocus,
          autoFocus: false,
          controller: _viewmodel.passwordController,
          prefixIcon: Icon(Icons.lock),
          margin: EdgeInsets.only(top: 20,left: 20,right: 20),
          text: 'Password',
          emptyError: 'Password should not be empty',
          lengthError: 'Password length should greater than 5',
          minLength: 6,
          isObscurred: true,
        ),
        Container(
            margin: EdgeInsets.only(top: 70,left: 20,right: 20),
            alignment: Alignment.center,
            child:Wrap(
                children:[
                  PrimaryButton(
                      text: 'LOGIN',
                      txtColor: AppColors.WHITE,
                      bgColor: AppColors.PRIMARY_COLOR,
                      fontfamily: AppFont.FONT,
                      fontWeight: FontWeight.w500,
                      fontSize: AppDimen.TEXT_SMALL,
                      radius: 5,
                      onPressed:(){
                        if(_formKey.currentState.validate()) {
                          bloc.add(
                              LoginUser(
                                  phone: _viewmodel.phoneController.text,
                                  password: _viewmodel.passwordController.text
                              )
                          );
                        }
                      }),
                ]
            )
        ),
        Or(),
        Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            margin: EdgeInsets.only(top: 40),
            alignment: Alignment.center,
            child:Wrap(
                children:[
                  DoubleColorButton(
                      text1: "Don't have an account? ",
                      text2: 'Create',
                      txtColor: AppColors.BLACK,
                      width: 250,
                      fontfamily: AppFont.FONT,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimen.TEXT_SMALL,
                      onPressed:(){
                        App().setNavigation(context, AppRoutes.APP_REGISTER);
                      })
                ]
            )
        ),
      ],
    );
  }
}

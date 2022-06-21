import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/input_field.dart';
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
import 'package:inses_app/widgets/loader.dart';
import 'package:inses_app/widgets/mini_title.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  NetworkBloc bloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ProfileViewModel(App());
    bloc = NetworkBloc(appRepository: appRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App().appBarBack(context, 'Contact'),
      body:  Form(
        key: _formKey,
        child:BlocBuilder<NetworkBloc,NetworkState>(
          bloc: bloc,
          builder: (context,state){
            if(state is Empty || state is Loading){
              return buildView(true);
            }else if(state is Error){
              return ErrorItem();
            }else if(state is Initial || state is MessageAdded){
              viewModel.messageController.text = '';
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
          text: 'Message',
        ),
        InputField(
            text: 'Enter your Message',
            isShadow: false,
            errorMaxLines: 3,
            autoFocus: true,
            focusNode: viewModel.messageFocus,
            margin: EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 20),
            controller: viewModel.messageController,
            emptyErrorText: 'Please Enter a message',
            enabledBorderColor: AppColors.WHITE_1,
            enabledBorderWidth: 1.0,
            focusedBorderColor: AppColors.SECONDARY_COLOR,
            hintColor: AppColors.GRAY_2,
            focusedBorderWidth: 1.0,
            inputType: TextInputType.multiline,
            bgColor: AppColors.WHITE,
            prefixIcon: Padding(
              padding: EdgeInsets.only(bottom: 70),
              child: Icon(Icons.message),
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
                text: 'SEND',
                color: AppColors.WHITE,
                fontfamily: AppFont.FONT,
                fontSize: AppDimen.TEXT_SMALL,
                fontWeight: FontWeight.w400,
              ),
              onTap: (){
                  if(_formKey.currentState.validate()) {
                    bloc.add(AddMessage(message: viewModel.messageController.text));
                  }
                },
            )
        )
      ],
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}

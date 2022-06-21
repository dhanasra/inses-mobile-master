import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/model/payment_history.dart';
import 'package:inses_app/network/app_api_client.dart';
import 'package:inses_app/network/app_repository.dart';
import 'package:inses_app/network/bloc/network_bloc.dart';
import 'package:inses_app/network/bloc/network_event.dart';
import 'package:inses_app/network/bloc/network_state.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/view_models/profile_view_model.dart';
import 'package:inses_app/widgets/booking_empty.dart';
import 'package:inses_app/widgets/error_item.dart';
import 'package:inses_app/widgets/loader.dart';
import 'package:inses_app/widgets/payment_item.dart';

class PaymentHistory extends StatefulWidget {

  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {

  NetworkBloc bloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));
  ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ProfileViewModel(App());
    bloc = NetworkBloc(appRepository: appRepository);
    bloc.add(GetPaymentHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App().appBarBack(context, 'Your Payments'),
      body: Container(
        child: BlocBuilder<NetworkBloc,NetworkState>(
          bloc: bloc,
          builder: (context,state){
            if(state is Initial || state is Loading){
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Loader()
                ],
              );
            }if(state is Empty){
              return EmptyBooking();
            }else if(state is Error){
              return ErrorItem();
            }else if(state is GotPaymentHistory){
              return buildView(state.payments);
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget buildView(List<PaymentHistoryModel> payments){
    return ListView.builder(
      itemCount: payments.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        return PaymentCardItem(payment: payments[index],);
      },
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inses_app/model/bookings.dart';
import 'package:inses_app/widgets/booking_empty.dart';
import 'package:inses_app/widgets/booking_item.dart';
import 'package:http/http.dart';
import 'package:inses_app/network/app_api_client.dart';
import 'package:inses_app/network/app_repository.dart';
import 'package:inses_app/network/bloc/network_bloc.dart';
import 'package:inses_app/network/bloc/network_event.dart';
import 'package:inses_app/network/bloc/network_state.dart';
import 'package:inses_app/widgets/error_item.dart';
import 'package:inses_app/widgets/loader.dart';

class PastBooking extends StatefulWidget {

  @override
  _PastBookingState createState() => _PastBookingState();
}

class _PastBookingState extends State<PastBooking> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  ScrollController controller;

  NetworkBloc bloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));

  @override
  void initState() {
    controller = ScrollController();

    bloc = NetworkBloc(appRepository: appRepository);
    bloc.add(GetBookingHistory());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          }else if(state is GotBookings){
            return buildView(state.bookings);
          }else{
            return Container();
          }
        },
      ),
    );
  }

  Widget buildView(List<BookingModel> bookings){
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: ()async{
        await Future.delayed(Duration(seconds: 5));
      },
      child: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context,index){
          print("==========================${bookings.length}");
            return BookingItem(bookings[index]);
        },
        controller: controller,
      ),
    );
  }


  @override
  void dispose() {
    bloc.close();
    controller.dispose();
    super.dispose();
  }
}

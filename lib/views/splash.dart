import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/database/constants.dart';
import 'package:inses_app/view_models/splash_bloc/splash_bloc.dart';
import 'package:inses_app/view_models/splash_bloc/splash_event.dart';
import 'package:inses_app/view_models/splash_bloc/splash_state.dart';
import 'package:inses_app/widgets/loader.dart';
import 'package:inses_app/widgets/splash_widget.dart';
import 'launch.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final bloc = SplashBloc();
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
    StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    checkConnectivity();
    bloc.add(NavigateToHome());
    super.initState();
  }

  void checkConnectivity() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
    }else{
      App().setNavigation(context, AppRoutes.APP_NO_INTERNET);
    }


    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        setState(() => AppConstants.INTERNET = 'OK');
        break;
      case ConnectivityResult.mobile:
      setState(() => AppConstants.INTERNET = 'OK');
      break;
      case ConnectivityResult.none:
        setState(() => AppConstants.INTERNET = 'NotOK');
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => bloc,
        child: Scaffold(
          body: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              print(state);
              if (state is Initial || state is Loading || state is Loaded) {
                return
                  Stack(
                    children: [
                      SplashWidget(),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Loader()
                      )
                    ],
                  );
              } else if (state is Authenticate || state is Error) {
                return Launch();
              } else if (state is Welcome) {
                App().setNavigation(context, AppRoutes.APP_HOME_MAIN);
                return SplashWidget();
              } else {
                return SplashWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}

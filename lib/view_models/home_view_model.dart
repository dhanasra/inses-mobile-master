import 'package:inses_app/app/app.dart';
import 'package:inses_app/model/service.dart';

class HomeViewModel{

  static HomeViewModel _instance;

  static List<ServiceModel> category=[];
  static List services=[];
  static List offers=[];
  static String loginStatus;

  factory HomeViewModel(App app){
    _instance ??= HomeViewModel._internal();
    return _instance;
  }

  HomeViewModel._internal(){
    init();
  }

  void init(){

  }
}
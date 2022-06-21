import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/border_container.dart';
import 'package:inses_app/comps/content.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/resources/app_colors.dart';
import 'package:inses_app/resources/app_dimen.dart';
import 'package:inses_app/resources/app_font.dart';
import 'package:inses_app/view_models/order_view_model.dart';
import 'package:inses_app/views/time_item.dart';
import 'package:inses_app/widgets/date_item.dart';
import 'package:inses_app/widgets/mini_title.dart';
import 'package:intl/intl.dart';

class DateTimeSelect extends StatefulWidget {

  @override
  _DateTimeSelectState createState() => _DateTimeSelectState();
}

class _DateTimeSelectState extends State<DateTimeSelect> {

  StreamController dateController;
  StreamController timeController;
  OrderViewModel viewModel;

  @override
  void initState() {
    viewModel = OrderViewModel(App());
    dateController = StreamController();
    timeController = StreamController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App().appBarBack(context, 'Schedule Your Service'),
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
                  if(OrderViewModel.date==null || OrderViewModel.startTime.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Schedule your date and time',style: TextStyle(fontSize: AppDimen.TEXT_SMALL),)));
                  }else{
                    App().setNavigation(context, AppRoutes.APP_ORDER_FLOW_5);
                  }
                }
            )
          ],
        ),
      ),
      body: Container(
        child: buildView(),
      ),
    );
  }

  Widget buildView(){
    return ListView(
      children: [
        MiniTitle(text: 'When do you need this service',margin: EdgeInsets.only(top: 30,bottom: 10,left: 20),),
        StreamBuilder(
          stream: dateController.stream,
          builder: (context,AsyncSnapshot shot){
            return BorderContainer(
              margin: EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OnTapField(
                      child: DateItem(date: '${viewModel.dateformatter.format(DateTime.now().add(Duration(days: 1)))}',day: '${viewModel.dayformatter.format(DateTime.now())}',isSelected: shot.hasData?shot.data=='today'?true:false:false,),
                      onTap: (){
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        final String formatted = formatter.format(DateTime.now().add(Duration(days: 1)));
                        OrderViewModel.date = formatted;
                        dateController.add('today');
                      }
                  ),
                  OnTapField(
                      child: DateItem(date: '${viewModel.dateformatter.format(DateTime.now().add(Duration(days: 2)))}',day: '${viewModel.dayformatter.format(DateTime.now().add(Duration(days: 1)))}',isSelected: shot.hasData?shot.data=='tomorrow'?true:false:false,),
                      onTap: (){
                        final DateFormat formatter1 = DateFormat('yyyy-MM-dd');
                        final String formatted1 = formatter1.format(DateTime.now().add(Duration(days: 2)));
                        OrderViewModel.date = formatted1;
                        dateController.add('tomorrow');
                      }
                  ),
                  OrderViewModel.date==null?OnTapField(
                      child: DateItem(date: 'pick',day: 'Pick date',isSelected: shot.hasData?shot.data=='pick'?true:false:false,),
                      onTap: (){
                        selectDate(context);
                        dateController.add('pick');
                      }
                  ):OnTapField(
                      child: DateItem(date: 'pick',day: OrderViewModel.date,isSelected: shot.hasData?shot.data=='pick'?true:false:false,),
                      onTap: (){
                        selectDate(context);
                        dateController.add('pick');
                      }
                  )
                ],
              ),
            );
          }),
        MiniTitle(text: 'Select Time',margin: EdgeInsets.only(top: 10,bottom: 10,left: 20)),
        StreamBuilder(
            stream: timeController.stream,
            builder: (context,AsyncSnapshot shot){
              return BorderContainer(
                radius: 4,
                borderColor: AppColors.WHITE_1,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: (2.2),
                  crossAxisSpacing: 10,
                  padding: EdgeInsets.only(bottom:7),
                  mainAxisSpacing: 15,
                  crossAxisCount: 3,
                  children: [
                    OnTapField(
                        child: TimeItem(time: '10AM - 11AM', isSelected: shot.hasData?shot.data=='10-11'?true:false:false,),
                        onTap: (){
                          OrderViewModel.startTime = '10:00:00';
                          OrderViewModel.endTime = '11:00:00';
                          timeController.add('10-11');
                        }
                    ),
                    OnTapField(
                        child: TimeItem(time: '11AM - 12PM', isSelected: shot.hasData?shot.data=='11-12'?true:false:false,),
                        onTap: (){
                          OrderViewModel.startTime = '11:00:00';
                          OrderViewModel.endTime = '12:00:00';
                          timeController.add('11-12');
                        }
                    ),
                    OnTapField(
                        child: TimeItem(time: '12PM -  1PM', isSelected: shot.hasData?shot.data=='12-1'?true:false:false,),
                        onTap: (){
                          OrderViewModel.startTime = '12:00:00';
                          OrderViewModel.endTime = '13:00:00';
                          timeController.add('12-1');
                        }
                    ),
                    OnTapField(
                        child: TimeItem(time: '1PM - 2PM', isSelected: shot.hasData?shot.data=='1-2'?true:false:false,),
                        onTap: (){
                          OrderViewModel.startTime = '13:00:00';
                          OrderViewModel.endTime = '14:00:00';
                          timeController.add('1-2');
                        }
                    ),
                    OnTapField(
                        child: TimeItem(time: '2PM - 3PM', isSelected: shot.hasData?shot.data=='2-3'?true:false:false,),
                        onTap: (){
                          OrderViewModel.startTime = '14:00:00';
                          OrderViewModel.endTime = '15:00:00';
                          timeController.add('2-3');
                        }
                    ),
                    OnTapField(
                        child: TimeItem(time: '3PM -  4PM', isSelected: shot.hasData?shot.data=='3-4'?true:false:false,),
                        onTap: (){
                          OrderViewModel.startTime = '15:00:00';
                          OrderViewModel.endTime = '16:00:00';
                          timeController.add('3-4');
                        }
                    ),
                    OnTapField(
                        child: TimeItem(time: '4PM -  5PM', isSelected: shot.hasData?shot.data=='4-5'?true:false:false,),
                        onTap: (){
                          OrderViewModel.startTime = '16:00:00';
                          OrderViewModel.endTime = '17:00:00';
                          timeController.add('4-5');
                        }
                    ),
                    OnTapField(
                        child: TimeItem(time: '5PM - 6PM', isSelected: shot.hasData?shot.data=='5-6'?true:false:false,),
                        onTap: (){
                          OrderViewModel.startTime = '17:00:00';
                          OrderViewModel.endTime = '18:00:00';
                          timeController.add('5-6');
                        }
                    ),
                    OnTapField(
                        child: TimeItem(time: '6PM - 7PM', isSelected: shot.hasData?shot.data=='6-7'?true:false:false,),
                        onTap: (){
                          OrderViewModel.startTime = '18:00:00';
                          OrderViewModel.endTime = '19:00:00';
                          timeController.add('6-7');
                        }
                    ),
                    OnTapField(
                        child: TimeItem(time: '7PM -  8PM', isSelected: shot.hasData?shot.data=='7-8'?true:false:false,),
                        onTap: (){
                          OrderViewModel.startTime = '19:00:00';
                          OrderViewModel.endTime = '20:00:00';
                          timeController.add('7-8');
                        }
                    ),
                    OnTapField(
                        child: TimeItem(time: '8PM -  9PM', isSelected: shot.hasData?shot.data=='8-9'?true:false:false,),
                        onTap: (){
                          OrderViewModel.startTime = '20:00:00';
                          OrderViewModel.endTime = '21:00:00';
                          timeController.add('8-9');
                        }
                    ),
                    OnTapField(
                        child: TimeItem(time: '9PM - 10PM', isSelected: shot.hasData?shot.data=='9-10'?true:false:false,),
                        onTap: (){
                          OrderViewModel.startTime = '21:00:00';
                          OrderViewModel.endTime = '22:00:00';
                          timeController.add('9-10');
                        }
                    ),
                  ],
                ),
              );
            })
      ],
    );
  }

  Future<Null> selectDate(BuildContext context) async {

    final DateTime picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.SECONDARY_COLOR, // header background color
              onPrimary: AppColors.WHITE, // header text color
              onSurface: AppColors.BLACK, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.GRAY, // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );

    if (picked != null ){
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(picked);
      OrderViewModel.date = formatted;

      setState(() {});
    }else{

    }
  }

  @override
  void dispose() {
    dateController.close();
    timeController.close();
    super.dispose();
  }
}

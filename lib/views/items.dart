import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inses_app/app/app.dart';
import 'package:inses_app/app/app_routes.dart';
import 'package:inses_app/comps/tap_field.dart';
import 'package:inses_app/model/category.dart';
import 'package:inses_app/model/offer.dart';
import 'package:inses_app/model/service.dart';
import 'package:inses_app/network/app_api_client.dart';
import 'package:inses_app/network/app_repository.dart';
import 'package:inses_app/network/bloc/network_bloc.dart';
import 'package:inses_app/network/bloc/network_event.dart';
import 'package:inses_app/network/bloc/network_state.dart';
import 'package:inses_app/view_models/edit_view_model.dart';
import 'package:inses_app/widgets/error_item.dart';
import 'package:inses_app/widgets/loader.dart';
import 'package:inses_app/widgets/mini_title.dart';
import 'package:inses_app/widgets/service_item.dart';
import 'package:inses_app/widgets/service_sub_item.dart';

class Items extends StatefulWidget {

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {

  NetworkBloc bloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));

  @override
  void initState() {
    super.initState();
    bloc = NetworkBloc(appRepository: appRepository);
    bloc.add(EditViewModel.type==0?GetCategories():EditViewModel.type==1?GetServices():GetOffers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App().appBarBack(
        context,
        'Select your need',
        child: SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                EditViewModel.type==0?
                App().setNavigation(context, AppRoutes.APP_ADD_CATEGORY):
                EditViewModel.type==1?
                App().setNavigation(context, AppRoutes.APP_SELECT_CATEGORY):
                App().setNavigation(context, AppRoutes.APP_ADD_OFFER);
              }
          ),
        )
      ),
      body: Container(
        child: BlocBuilder<NetworkBloc,NetworkState>(
          bloc: bloc,
          builder: (context,state){
            if(state is Initial || state is Loading){
              return buildView(true,[],[],[]);
            }else if(state is Error){
              return ErrorItem();
            }else if(state is GotServices){
              return buildView(false,state.services,[],[]);
            }else if(state is GotCategories){
              return buildView(false,[],state.categories,[]);
            }else if(state is GotOffers){
              return buildView(false,[],[],state.offers);
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget buildView(bool isLoading,List<ServiceModel> services,List<CategoryModel> categories,List<OfferModel> offers){
    return ListView(
      children: [
        Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                isLoading?Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Loader()
                  ],
                ):EditViewModel.type==0?
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                  ),
                  itemBuilder: (context, index) {
                    return ServiceItem(
                      serviceModel: categories[index],
                      onPressed: (){
                        EditViewModel.category = categories[index];
                        App().setNavigation(context, AppRoutes.APP_ED_CATEGORY);
                      },
                    );
                  },
                ):EditViewModel.type==1?
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: services.length,
                    itemBuilder: (context,index){
                      return
                        ServiceSubItem(
                          service: services[index],
                          onpressed: (){
                            EditViewModel.service = services[index];
                            App().setNavigation(context, AppRoutes.APP_ED_SERVICE);
                          },
                        );
                    }
                ): ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: offers.length,
                    itemBuilder: (context,index){
                      ServiceModel service = ServiceModel(name: offers[index].old+offers[index].txt+offers[index].offer,icon: offers[index].img);
                      return
                        ServiceSubItem(
                          service: service,
                          onpressed: (){
                            EditViewModel.offer = offers[index];
                            App().setNavigation(context, AppRoutes.APP_ED_OFFER);
                          },
                        );
                    }
                )
              ],
            )
        ),
      ],
    );
  }
}

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


class SelectCategory extends StatefulWidget {

  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {

  NetworkBloc bloc;
  AppRepository appRepository = AppRepository(appApiClient: AppApiClient(httpClient: Client()));


  @override
  void initState() {
    super.initState();
    bloc = NetworkBloc(appRepository: appRepository);
    bloc.add(GetCategories());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App().appBarBack(
          context,
          'Select category',
      ),
      body: Container(
        child: BlocBuilder<NetworkBloc,NetworkState>(
          bloc: bloc,
          builder: (context,state){
            if(state is Initial || state is Loading){
              return buildView(true,[],[],[]);
            }else if(state is Error){
              return ErrorItem();
            }else if(state is GotCategories){
              return buildView(false,[],state.categories,[]);
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
                MiniTitle(text: 'Select Category',margin: EdgeInsets.only(bottom: 20),),
                isLoading?Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Loader()
                  ],
                ):
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
                        App().setNavigation(context, AppRoutes.APP_ADD_SERVICE);
                      },
                    );
                  },
                )
              ],
            )
        ),
      ],
    );
  }
}

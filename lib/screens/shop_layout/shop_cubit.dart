import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/models/home_model.dart';
import 'package:newshopapp/network/end_points.dart';
import 'package:newshopapp/network/remote/dio_helper.dart';
import 'package:newshopapp/screens/categories/categories_page.dart';
import 'package:newshopapp/screens/favorites/favorites_page.dart';
import 'package:newshopapp/screens/products/products_page.dart';
import 'package:newshopapp/screens/settings/settings_page.dart';
import 'package:newshopapp/screens/shop_layout/shop_states.dart';

import '../../shared/component.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context) =>  BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsPage(),
    const CategoriesPage(),
    const FavoritesPage(),
    const SettingsPage()
  ];
  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
  HomeModel? homeModel;
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
        token:token
    ).then((value){
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel!.data!.banners![0].image.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      printFullText(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
}
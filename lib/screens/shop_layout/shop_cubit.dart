import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/routes/app_routes.dart';
import 'package:newshopapp/screens/categories/categories_page.dart';
import 'package:newshopapp/screens/favorites/favorites_page.dart';
import 'package:newshopapp/screens/products/products_page.dart';
import 'package:newshopapp/screens/settings/settings_page.dart';
import 'package:newshopapp/screens/shop_layout/shop_states.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context) =>  BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsPage(),
    CategoriesPage(),
    FavoritesPage(),
    SettingsPage()
  ];
  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
}
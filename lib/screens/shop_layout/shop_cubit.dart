import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/models/home_model.dart';
import 'package:newshopapp/models/login_model.dart';
import 'package:newshopapp/network/end_points.dart';
import 'package:newshopapp/network/remote/dio_helper.dart';
import 'package:newshopapp/screens/categories/categories_page.dart';
import 'package:newshopapp/screens/favorites/favorites_page.dart';
import 'package:newshopapp/screens/products/products_page.dart';
import 'package:newshopapp/screens/settings/settings_page.dart';
import 'package:newshopapp/screens/shop_layout/shop_states.dart';

import '../../models/categories_model.dart';
import '../../models/change_favorites_model.dart';
import '../../models/favorites_model.dart';
import '../../shared/component.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context) =>  BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsPage(),
    const CategoriesPage(),
    const FavoritesPage(),
     SettingsPage()
  ];
  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int?,bool?> favorites = {};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
        token:token
    ).then((value){
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel!.data!.banners![0].image.toString());
      for (var element in homeModel!.data!.products!) {
        favorites.addAll({
          element.id : element.inFavorite
        });
      }
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      printFullText(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: GET_CATEGORIES,
        token:token
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error){
      printFullText(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId){
    emit(ShopLoadingHomeDataState());
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        token:token,
        data: {
          'product_id' : productId
        }
    ).then((value){
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status!){
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavoritesData();
      }
      printFullText(value.data.toString());
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error){
      printFullText(error.toString());
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData(){
    emit(ShopLoadingGetFavoritesDataState());
    DioHelper.getData(
        url: FAVORITES,
        token:token
    ).then((value){
     favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error){
      printFullText(error.toString());
      emit(ShopErrorGetFavoritesDataState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData(){
    emit(ShopLoadingGetProfileDataState());
    DioHelper.getData(
        url: PROFILE,
        token:token
    ).then((value){
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessGetProfileDataState(userModel: userModel));
    }).catchError((error){
      printFullText(error.toString());
      emit(ShopErrorGetProfileDataState());
    });
  }
}
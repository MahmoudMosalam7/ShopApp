import 'package:newshopapp/models/change_favorites_model.dart';
import 'package:newshopapp/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {

  final ChangeFavoritesModel? model;
  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}


class ShopLoadingGetFavoritesDataState extends ShopStates {}

class ShopSuccessGetFavoritesDataState extends ShopStates {}

class ShopErrorGetFavoritesDataState extends ShopStates {}

class ShopLoadingGetProfileDataState extends ShopStates {}

class ShopSuccessGetProfileDataState extends ShopStates {
  final ShopLoginModel? userModel;

  ShopSuccessGetProfileDataState({required this.userModel});
}

class ShopErrorGetProfileDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel? userModel;

  ShopSuccessUpdateUserState({required this.userModel});
}

class ShopErrorUpdateUserState extends ShopStates {}
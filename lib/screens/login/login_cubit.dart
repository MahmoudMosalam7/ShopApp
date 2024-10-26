import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/network/end_points.dart';
import 'package:newshopapp/network/remote/dio_helper.dart';
import 'package:newshopapp/screens/login/login_states.dart';

import '../../models/login_model.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) =>  BlocProvider.of(context);
  ShopLoginModel? loginModel ;
  void userLogin({
    required String email,
    required String password,
  }){
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email' : email,
      'password': password
    }).then((value)
    {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }
    ).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_outlined :
    Icons.visibility_off_outlined ;
    emit(LoginChangePasswordVisibilityState());
  }
}
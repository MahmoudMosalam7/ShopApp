import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/network/end_points.dart';
import 'package:newshopapp/network/remote/dio_helper.dart';
import 'package:newshopapp/screens/login/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) =>  BlocProvider.of(context);
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
      print(value.data);
      emit(LoginSuccessState());
    }
    ).catchError((error){
      print(error);
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
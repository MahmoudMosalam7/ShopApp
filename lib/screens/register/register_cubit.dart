import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/screens/register/register_states.dart';

import '../../models/login_model.dart';
import '../../network/end_points.dart';
import '../../network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) =>  BlocProvider.of(context);
  ShopLoginModel? loginModel ;
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name' : name,
      'phone' : phone,
      'email' : email,
      'password': password
    }).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel);
      emit(RegisterSuccessState(loginModel!));
    }
    ).catchError((error){
      print(error);
      emit(RegisterErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_outlined :
    Icons.visibility_off_outlined ;
    emit(RegisterChangePasswordVisibilityState());
  }
}
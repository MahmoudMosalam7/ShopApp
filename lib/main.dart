import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/routes/app_router.dart';
import 'package:newshopapp/routes/app_routes.dart';
import 'package:newshopapp/shared/bloc_observer.dart';

import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  String startPage;
  bool? isOnBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');
  if(isOnBoarding != null){
    if(token != null) startPage = AppRoutes.SHOP_LAYOUT;
    else startPage = AppRoutes.LOGIN;
  }else startPage = AppRoutes.ON_BOARDING;
  runApp( MyApp(startPage: startPage,));
}

class MyApp extends StatelessWidget {
  final String? startPage;
   MyApp({this.startPage});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: startPage,
        );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/routes/app_router.dart';
import 'package:newshopapp/routes/app_routes.dart';
import 'package:newshopapp/screens/shop_layout/shop_cubit.dart';
import 'package:newshopapp/shared/bloc_observer.dart';
import 'package:newshopapp/shared/component.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  String startPage;
  bool? isOnBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  if(isOnBoarding != null){
    startPage = AppRoutes.SHOP_LAYOUT;
  }else {
    startPage = AppRoutes.ON_BOARDING;
  }
  runApp( MyApp(startPage: startPage,));
}

class MyApp extends StatelessWidget {
  final String? startPage;
   const MyApp({super.key, this.startPage});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => ShopCubit()
                ..getHomeData()
                ..getCategoriesData()
                ..getFavoritesData()
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: startPage,
        ));
  }
}



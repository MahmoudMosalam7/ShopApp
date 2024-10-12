import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:newshopapp/routes/app_router.dart';
import 'package:newshopapp/routes/app_routes.dart';
import 'package:newshopapp/screens/onboarding/on_boarding_page.dart';
import 'package:newshopapp/shared/bloc_observer.dart';

import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.ON_BOARDING,
    );
  }
}



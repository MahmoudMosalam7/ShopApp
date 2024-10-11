import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:newshopapp/screens/onboarding/onboarding_page.dart';
import 'package:newshopapp/shared/bloc_observer.dart';

import 'network/local/cache_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
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
      home: OnBoardingPage(),
    );
  }
}



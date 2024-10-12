// Generated code - do not modify by hand

import 'package:flutter/material.dart';
import '../screens/login/login_page.dart';
import '../screens/onboarding/on_boarding_page.dart';
import '../screens/register/register_page.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.LOGIN:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case AppRoutes.ON_BOARDING:
        return MaterialPageRoute(
          builder: (_) => OnBoardingPage(),
        );
      case AppRoutes.REGISTER:
        return MaterialPageRoute(
          builder: (_) => RegisterPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text('Not Found')),
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}

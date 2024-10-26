// Generated code - do not modify by hand

import 'package:flutter/material.dart';
import '../screens/categories/categories_page.dart';
import '../screens/favorites/favorites_page.dart';
import '../screens/login/login_page.dart';
import '../screens/onboarding/on_boarding_page.dart';
import '../screens/products/products_page.dart';
import '../screens/register/register_page.dart';
import '../screens/search/search_page.dart';
import '../screens/settings/settings_page.dart';
import '../screens/shop_layout/shop_layout_page.dart';
import 'app_routes.dart';
class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.CATEGORIES:
        return MaterialPageRoute(
          builder: (_) => const CategoriesPage(),
        );
      case AppRoutes.FAVORITES:
        return MaterialPageRoute(
          builder: (_) => const FavoritesPage(),
        );
      case AppRoutes.LOGIN:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case AppRoutes.ON_BOARDING:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingPage(),
        );
      case AppRoutes.PRODUCTS:
        return MaterialPageRoute(
          builder: (_) => const ProductsPage(),
        );
      case AppRoutes.REGISTER:
        return MaterialPageRoute(
          builder: (_) => RegisterPage(),
        );
      case AppRoutes.SEARCH:
        return MaterialPageRoute(
          builder: (_) => SearchPage(),
        );
      case AppRoutes.SETTINGS:
        return MaterialPageRoute(
          builder: (_) => SettingsPage(),
        );
      case AppRoutes.SHOP_LAYOUT:
        return MaterialPageRoute(
          builder: (_) => const ShopLayoutPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Not Found')),
            body: const Center(child: Text('Page not found')),
          ),
        );
    }
  }
}

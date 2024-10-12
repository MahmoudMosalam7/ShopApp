import 'package:flutter/material.dart';
import 'package:newshopapp/network/local/cache_helper.dart';
import 'package:newshopapp/routes/app_routes.dart';
import 'package:newshopapp/shared/component.dart';

class ShopLayoutPage extends StatelessWidget {
  const ShopLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Text('Shopping '),
      ),
      body: TextButton(
        onPressed: (){
          CacheHelper.removeData(key: 'token').then((value){
            navigateAndFinish(context, AppRoutes.LOGIN);
          });
        },
        child: Text('logout'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/routes/app_routes.dart';
import 'package:newshopapp/screens/shop_layout/shop_cubit.dart';
import 'package:newshopapp/screens/shop_layout/shop_states.dart';
import 'package:newshopapp/shared/component.dart';

import '../../shared/color.dart';

class ShopLayoutPage extends StatelessWidget {
  const ShopLayoutPage({super.key});
 //ShopCubit
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ShopCubit()),
        ],
        child: BlocConsumer<ShopCubit,ShopStates>(
          builder: (BuildContext context, ShopStates state) {
            var cubit = ShopCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title:const Text('Shopping '),
                actions: [
                  IconButton(
                      onPressed: (){
                        navigateTo(context, AppRoutes.SEARCH);
                      },
                      icon: Icon(Icons.search)
                  )
                ],
              ),

              body: cubit.bottomScreens[cubit.currentIndex],
              bottomNavigationBar:BottomNavigationBar(
                onTap: (index){
                  cubit.changeBottom(index);
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: defaultActiveColor,
                unselectedItemColor: defaultInactiveColor,

                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                    label: 'Home'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps),
                    label: 'Categories'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                    label: 'Favorites'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                    label: 'Settings',

                  ),
                ],

              ) ,
            );
          },
          listener: (BuildContext context, ShopStates state) {  },)
    );
  }
}

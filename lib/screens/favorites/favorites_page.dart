import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/color.dart';
import '../../shared/component.dart';
import '../shop_layout/shop_cubit.dart';
import '../shop_layout/shop_states.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopCubit.get(context);
        return state is! ShopLoadingGetFavoritesDataState ? ListView.separated(
            scrollDirection: Axis.vertical ,
            itemBuilder: (context,index) => buildListProductItem(
                cubit.favoritesModel!.data!.data![index].product,
              context
            ),
            separatorBuilder: (context,index) =>myDivider(),
            itemCount: cubit.favoritesModel!.data!.data!.length
        ) :
        const Center(child: CircularProgressIndicator(
        color: defaultActiveColor,
        ),
        );
      },
      listener: (BuildContext context, ShopStates state) {  },);

  }

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/models/categories_model.dart';
import 'package:newshopapp/screens/shop_layout/shop_cubit.dart';
import 'package:newshopapp/screens/shop_layout/shop_states.dart';
import 'package:newshopapp/shared/component.dart';

import '../../shared/color.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopCubit.get(context);
        return cubit.categoriesModel != null ? ListView.separated(
            scrollDirection: Axis.vertical ,
            itemBuilder: (context,index) => buildCatItem(
                cubit.categoriesModel!.data!.data![index]
            ),
            separatorBuilder: (context,index) =>myDivider(),
            itemCount: cubit.categoriesModel!.data!.data!.length
        ) :
        const Center(child: CircularProgressIndicator(
          color: defaultActiveColor,
        ),
        );
      },
      listener: (BuildContext context, ShopStates state) {  },);
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image!),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover ,
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          model.name!,
          style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        const Spacer(),
        const Icon(
            Icons.arrow_forward_ios
        )
      ],
    ),
  );
}

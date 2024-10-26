import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/models/favorites_model.dart';

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
            itemBuilder: (context,index) => buildFavItem(
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

  Widget buildFavItem(Product? product,context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120.0,
      child: Row(
        children: [
          Stack(
              alignment: AlignmentDirectional.bottomStart,
              children:[
                Image(
                  image: NetworkImage(product!.image!),
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
                if(product.discount != 0)
                  Container(
                    color: defaultActiveColor,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white
                      ),
                    ),
                  )
              ]
          ),
          const SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      product.price.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultActiveColor
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    if(product.discount != 0)
                      Text(
                        product.oldPrice.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 10.0,
                            color: defaultInactiveColor,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: (){

                          ShopCubit.get(context).changeFavorites(product.id!);
                        },
                        icon:  CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context)
                              .favorites[product.id] == true
                              ? defaultActiveColor
                              : defaultInactiveColor,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        )
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

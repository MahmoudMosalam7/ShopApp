import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/models/home_model.dart';
import 'package:newshopapp/screens/shop_layout/shop_cubit.dart';
import 'package:newshopapp/screens/shop_layout/shop_states.dart';
import 'package:newshopapp/shared/color.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopCubit.get(context);
        return cubit.homeModel != null ?
        productsBuilder(cubit.homeModel) :
        const Center(child: CircularProgressIndicator(
          color: defaultActiveColor,
        ),
        );
      },
      listener: (BuildContext context, ShopStates state) {  },);
  }
  Widget productsBuilder(HomeModel? model) =>  SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        CarouselSlider(
          items: model!.data!.banners!.map((e)=>Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          )).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal
          ),
        ),
        const SizedBox(height: 10.0,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1/1.58,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                    model.data!.products!.length,
                    (index) => buildGridProducts(model.data!.products![index]),
                ),
            ),
        ),

      ],
    ),
  );
  Widget buildGridProducts(ProductsModel? model) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:[
            Image(
              image: NetworkImage('${model!.image}'),
              width: double.infinity,
              height: 200.0,
            ),
            if(model.discount != 0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price!.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultActiveColor
                    ),
                  ),
                  const SizedBox(width: 5.0,),
                  if(model.discount != 0)
                  Text(
                    '${model.oldPrice!.round()}',
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
                      onPressed: (){},
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 14.0,
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

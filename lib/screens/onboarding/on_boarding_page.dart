import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newshopapp/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/onboardingmodel.dart';
import '../../routes/app_routes.dart';
import '../../shared/component.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  var boardController = PageController();

  bool isLast = false;

  List<Onboardingmodel> boarding = [
    Onboardingmodel(
      image:
      'https://th.bing.com/th/id/R.2b27b5fd436cc67bfcd9311a06a1ac05?rik=MBuayEI8y5Y9eg&riu=http%3a%2f%2fclipart-library.com%2fnewhp%2f145-1458151_store-clipart-grocery-store-front-cartoon-image-of.png&ehk=voXV7jrqHTzjMgNYFwQBlDTvrOxcp2cvcydYnmM81U4%3d&risl=&pid=ImgRaw&r=0',
      title: 'On Boarding 1 Title',
      body: 'On Boarding 1 Body',
    ),
    Onboardingmodel(
      image:
      'https://media.istockphoto.com/vectors/online-shopping-ecommerce-concept-business-order-item-store-online-on-vector-id678490880?k=6&m=678490880&s=612x612&w=0&h=GK8XVot63bij2HoEwR0J1X8_EDnFxkBJ6PNpG0UstTE=',
      title: 'On Boarding 2 Title',
      body: 'On Boarding 2 Body',
    ),
    Onboardingmodel(
      image:
      'https://static.vecteezy.com/system/resources/previews/002/194/930/large_2x/3d-shopping-online-store-for-sale-mobile-e-commerce-3d-pink-pastel-background-shop-online-on-mobile-app-24-hours-shopping-cart-credit-card-minimal-shopping-online-store-device-3d-rendering-vector.jpg',
      title: 'On Boarding 3 Title',
      body: 'On Boarding 3 Body',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        actions: [
          defaultTextButton(
              onPressed: () {
                submit();
           },
            text: 'SKIP'
          )

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildBordingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.redAccent,
                    dotHeight: 10,
                    dotWidth: 10.0,
                    expansionFactor: 2,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBordingItem(Onboardingmodel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: NetworkImage(model.image),
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pacifico',
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pacifico',
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
    ],
  );
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        navigateAndFinish(context, AppRoutes.LOGIN);
      }
    });
  }
}

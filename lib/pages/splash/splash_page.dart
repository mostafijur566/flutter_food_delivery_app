import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/utils/colors.dart';
import 'package:flutter_food_delivery_app/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();

    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
      const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getSignInPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset('assets/images/logo.png',
              width: Dimensions.splashImage,
              ),
            ),
          ),

          Center(
            child: Text('The Best Food', style: TextStyle(
              fontFamily: 'Redressed',
              fontSize: Dimensions.height15 * 3,
              color: AppColors.mainColor
            ),)
          ),

        ],
      ),
    );
  }
}

import 'package:flutter_food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:flutter_food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:flutter_food_delivery_app/pages/cart/cart_page.dart';
import 'package:flutter_food_delivery_app/pages/food/RecommendedFoodDetail.dart';
import 'package:flutter_food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:flutter_food_delivery_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/home/home_page.dart';

class RouteHelper{
  static const String splashPage = '/splash-page';
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String signUpPage = '/sign-up-page';
  static const String signInPage = '/sign-in-page';

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageID) => '$popularFood?pageID=$pageID';
  static String getRecommendedFood(int pageID) => '$recommendedFood?pageID=$pageID';
  static String getCartPage()=> '$cartPage';
  static String getSignUpPage() => '$signUpPage';
  static String getSignInPage() => '$signInPage';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    
    GetPage(name: popularFood, page: () {
      var pageID = Get.parameters['pageID'];
      return PopularFoodDetail(pageID: int.parse(pageID!));
      
    }),
    GetPage(name: recommendedFood, page: () {
      var pageID = Get.parameters['pageID'];
      return RecommendedFoodDetail(pageID: int.parse(pageID!));
    }),

    GetPage(name: cartPage, page: (){
      return CartPage();
    }),

    GetPage(name: signUpPage, page: (){
      return SignUpPage();
    }),

    GetPage(name: signInPage, page: (){
      return SignInPage();
    }),
  ];
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/base/no_data_page.dart';
import 'package:flutter_food_delivery_app/controllers/cart_controller.dart';
import 'package:flutter_food_delivery_app/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery_app/pages/home/main_food_page.dart';
import 'package:flutter_food_delivery_app/utils/app_constants.dart';
import 'package:flutter_food_delivery_app/utils/dimensions.dart';
import 'package:flutter_food_delivery_app/widgets/app_icon.dart';
import 'package:flutter_food_delivery_app/widgets/big_text.dart';
import 'package:flutter_food_delivery_app/widgets/small_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                left: Dimensions.height20,
                right: Dimensions.height20,
                top: Dimensions.height20 * 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.height20 * 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    )
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController){
              return _cartController.getItems.length > 0 ? Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.height20,
                right: Dimensions.height20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  //color: Colors.red,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (cartController) {
                        var _cartList = cartController.getItems;
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index) {
                              return Container(
                                height: Dimensions.height20 * 5,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex =
                                        Get.find<PopularProductController>()
                                            .popularProductList
                                            .indexOf(
                                            _cartList[index].product!);

                                        if (popularIndex >= 0) {
                                          Get.toNamed(RouteHelper.getPopularFood(
                                              popularIndex));
                                        } else {
                                          var recommendedIndex = Get.find<
                                              RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(_cartList[index].product!);

                                          if (recommendedIndex < 0) {
                                            Get.snackbar('History product',
                                                'Product review is not available for history products',
                                                backgroundColor: Colors.redAccent,
                                                colorText: Colors.white
                                            );
                                          } else {
                                            Get.toNamed(
                                                RouteHelper.getRecommendedFood(
                                                    recommendedIndex));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.height20 * 5,
                                        height: Dimensions.height20 * 5,
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL +
                                                        '/uploads/' +
                                                        cartController
                                                            .getItems[index]
                                                            .img!),
                                                fit: BoxFit.cover),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.height20),
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.height10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: Dimensions.height20 * 5,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(
                                              text: cartController
                                                  .getItems[index].name!,
                                              color: Colors.black54,
                                            ),
                                            SmallText(text: 'Spicy'),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                BigText(
                                                  text:
                                                  '\$${cartController.getItems[index].price!.toString()}',
                                                  color: Colors.redAccent,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: Dimensions.height10,
                                                      bottom: Dimensions.height10,
                                                      left: Dimensions.height10,
                                                      right: Dimensions.height10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.height20),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(
                                                              _cartList[index]
                                                                  .product!,
                                                              -1);
                                                        },
                                                        child: Icon(
                                                          FontAwesomeIcons.minus,
                                                          size: 16,
                                                          color:
                                                          AppColors.signColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                        Dimensions.height10,
                                                      ),
                                                      BigText(
                                                          text: _cartList[index]
                                                              .quantity
                                                              .toString()),
                                                      SizedBox(
                                                        width:
                                                        Dimensions.height10,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController.addItem(
                                                              _cartList[index]
                                                                  .product!,
                                                              1);
                                                        },
                                                        child: Icon(
                                                          FontAwesomeIcons.plus,
                                                          size: 16,
                                                          color:
                                                          AppColors.signColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ),
              ) : NoDataPage();
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              height: Dimensions.height20 * 6,
              padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.height20,
                right: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    Dimensions.height20 * 2,
                  ),
                  topLeft: Radius.circular(Dimensions.height20 * 2),
                ),
              ),
              child: cartController.getItems.length > 0 ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.height20,
                        right: Dimensions.height20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.height20),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        BigText(
                            text: '\$' + cartController.totalAmount.toString()),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      cartController.addToHistory();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.height20,
                          right: Dimensions.height20),
                      child: BigText(
                        text: 'Check out',
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                          BorderRadius.circular(Dimensions.height20)),
                    ),
                  ),
                ],
              ) : Container(),
            );
          },
        ));
  }
}

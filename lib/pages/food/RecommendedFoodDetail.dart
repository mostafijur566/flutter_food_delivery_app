import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/controllers/cart_controller.dart';
import 'package:flutter_food_delivery_app/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:flutter_food_delivery_app/routes/route_helper.dart';
import 'package:flutter_food_delivery_app/utils/app_constants.dart';
import 'package:flutter_food_delivery_app/utils/colors.dart';
import 'package:flutter_food_delivery_app/utils/dimensions.dart';
import 'package:flutter_food_delivery_app/widgets/app_icon.dart';
import 'package:flutter_food_delivery_app/widgets/big_text.dart';
import 'package:flutter_food_delivery_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../cart/cart_page.dart';

class RecommendedFoodDetail extends StatelessWidget {

  final int pageID;

  RecommendedFoodDetail({Key? key, required this.pageID
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var product = Get.find<RecommendedProductController>().recommendedProductList[pageID];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      Get.back();
                      //Navigator.pop(context);
                    },
                    child: AppIcon(icon: Icons.clear)),
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems >= 1) {
                        Get.toNamed(RouteHelper.getCartPage());
                      }
                      else{
                        Get.snackbar('Oops!', 'Your cart is empty!',
                        backgroundColor: AppColors.mainColor,
                          colorText: Colors.white
                        );
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems >= 1 ?
                        Positioned(
                          right: 0,
                          top: 0,
                          child: AppIcon(
                            icon: Icons.circle,
                            size: 20,
                            iconColor: Colors.transparent,
                            backgroundColor: AppColors.mainColor,
                          ),) : Container(),

                        controller.totalItems >= 1 ?
                        Positioned(
                          right: controller.totalItems >= 9 ? 3: 6,
                          top: 3,
                          child: BigText(text: controller.totalItems.toString(), size: 12, color: Colors.white,
                          ),
                        ) : Container(),
                      ],
                    ),
                  );
                })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                width: double.maxFinite,
                child: Center(
                    child: BigText(
                  text: product.name!,
                  size: Dimensions.font26,
                )),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.height20)),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+'/uploads/'+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.height20, right: Dimensions.height20),
                  color: Colors.white,
                  child: ExpandableTextWidget(
                    text: product.description!,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.height20 * 2.5,
                  right: Dimensions.height20 * 2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                      iconSize: Dimensions.iconSize24,
                      icon: Icons.remove,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                    ),
                  ),
                  BigText(
                    text: '\$${product.price!} X ${controller.inCartItems.toString()}',
                    color: AppColors.mainBlackColor,
                    size: Dimensions.font26,
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                      iconSize: Dimensions.iconSize24,
                      icon: Icons.add,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
              child: Row(
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
                      child: Icon(Icons.favorite, color: AppColors.mainColor,
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      if(controller.inCartItems > 0) {
                        Get.snackbar('Go to cart',
                            'Added to cart successfully!',
                            backgroundColor: AppColors.mainColor,
                            colorText: Colors.white
                        );
                      }
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.height20,
                          right: Dimensions.height20),
                      child: BigText(
                        text: '\$${product.price!} Add to cart',
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.height20)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}

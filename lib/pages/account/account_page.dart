import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/utils/colors.dart';
import 'package:flutter_food_delivery_app/utils/dimensions.dart';
import 'package:flutter_food_delivery_app/widgets/account_widget.dart';
import 'package:flutter_food_delivery_app/widgets/app_icon.dart';
import 'package:flutter_food_delivery_app/widgets/big_text.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  final _auth = FirebaseAuth.instance;

  var userUid;
  var loggedInUser;

  var users;
  var name;
  var phone;
  var email;

  getData() async {
    final user = await _auth.currentUser;
    if (user != null) {
      userUid = user.uid;
      loggedInUser = user;
      setState(() {
        email = loggedInUser.email.toString();
      });
    }

    DatabaseEvent event = await ref.once();
    users = event.snapshot.value;
    setState(() {
      name = users[userUid]['name'];
      phone = users[userUid]['phone'];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: 'Profile',
          size: 24,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            //Profile Icon
            AppIcon(
              icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height45 + Dimensions.height30,
              size: Dimensions.height15 * 10,
            ),

            SizedBox(
              height: Dimensions.height30,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //name
                    AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5 / 2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(
                          text: name ?? '...',
                        )),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //phone
                    AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.phone,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5 / 2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(
                          text: phone ?? '...',
                        )),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //email
                    AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.email,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5 / 2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(
                          text: email ?? '...',
                        )),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //address
                    AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.location_on,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5 / 2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(
                          text: 'Fill in your address',
                        )),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //message
                    AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.message_outlined,
                          backgroundColor: Colors.redAccent,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5 / 2,
                          size: Dimensions.height10 * 5,
                        ),
                        bigText: BigText(
                          text: 'Message',
                        )),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

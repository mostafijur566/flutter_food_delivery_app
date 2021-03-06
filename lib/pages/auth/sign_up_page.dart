
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/utils/colors.dart';
import 'package:flutter_food_delivery_app/utils/dimensions.dart';
import 'package:flutter_food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';
import '../../widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");
  late var userUid;

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpIcons = [
      'assets/images/twitter.png',
      'assets/images/facebook.png',
      'assets/images/google.png',
    ];

    Future<void> _signUp() async {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        Get.snackbar('Oops!', 'Name field can\'t be empty',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }

      else if(phone.isEmpty){
        Get.snackbar('Oops!', 'Phone field can\'t be empty',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }

      else if(email.isEmpty){
        Get.snackbar('Oops!', 'Email field can\'t be empty',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }

      else if(password.isEmpty){
        Get.snackbar('Oops!', 'Password field can\'t be empty',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }

      else if(password.length < 6){
        Get.snackbar('Oops!', 'Password length should be at least 6',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }

      else{
        final newUser =
            await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        userUid = await _auth.currentUser?.uid;

        if (newUser != null) {
          await ref.child(userUid).set({
            "name": name,
            "phone": phone,
          });

          setState(() {
            emailController.clear();
            passwordController.clear();
            nameController.clear();
            phoneController.clear();
          });

          Get.snackbar('Great!', 'You have successfully created your account!',
              backgroundColor: AppColors.mainBlackColor,
              colorText: Colors.white
          );

          Get.toNamed(RouteHelper.getSignInPage());
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.screenHeight * 0.05,
            ),
            Hero(
              tag: 'logo',
              child: Container(
                height: Dimensions.screenHeight * 0.25,
                child: const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo.png'),
                    backgroundColor: Colors.white,
                    radius: 80,
                  ),
                ),
              ),
            ),
            AppTextField(
              emailController: emailController,
              hintText: 'Email',
              icon: Icons.email,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              emailController: passwordController,
              hintText: 'Password',
              icon: Icons.password_sharp,
              hideText: true,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              emailController: nameController,
              hintText: 'Name',
              icon: Icons.person,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              emailController: phoneController,
              hintText: 'Phone',
              icon: Icons.phone,
            ),
            SizedBox(
              height: Dimensions.height30,
            ),
            GestureDetector(
              onTap: () {
                try {
                  setState(() {
                    _signUp();
                  });

                } catch (e) {
                  Get.snackbar(e.toString(), e.toString());
                }
              },
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor),
                child: Center(
                  child: BigText(
                    text: 'Sign Up',
                    color: Colors.white,
                    size: Dimensions.font26,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                text: 'Have an account already?',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),
            RichText(
              text: TextSpan(
                text: 'Or, login with',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),
            Wrap(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(signUpIcons[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

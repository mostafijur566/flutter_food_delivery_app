import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:flutter_food_delivery_app/utils/colors.dart';
import 'package:flutter_food_delivery_app/utils/dimensions.dart';
import 'package:flutter_food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';
import '../../widgets/app_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var signUpIcons = [
    'assets/images/twitter.png',
    'assets/images/facebook.png',
    'assets/images/google.png',
  ];

  @override
  Widget build(BuildContext context) {


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

            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: Dimensions.height20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello',
                    style: TextStyle(
                      fontSize: Dimensions.font20 * 3 + Dimensions.font20 / 2,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  Text('Sign into your account',
                    style: TextStyle(
                        fontSize: Dimensions.font20 ,
                      color: Colors.grey[500]
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
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
              height: Dimensions.height30,
            ),
            GestureDetector(
              onTap: () async{
                email = emailController.text;
                password = passwordController.text;

                try {
                  final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(user != null){
                    Get.offNamed(RouteHelper.getInitial());
                  }
                  else{
                    Get.snackbar('Oops!', 'Incorrect email or password!',
                    backgroundColor: Colors.redAccent,
                      colorText: Colors.white
                    );
                  }
                } catch (e) {
                  Get.snackbar('Oops!', 'Incorrect email or password!',
                  backgroundColor: Colors.redAccent,
                      colorText: Colors.white);
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
                    text: 'Sign In',
                    color: Colors.white,
                    size: Dimensions.font26,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height30),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account?',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = () => Get.to(() => SignUpPage()),
                  text: ' Create',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
              ]
              ),

            ),


            SizedBox(height: Dimensions.height20),
            RichText(
              text: const TextSpan(
                text: 'Or, login with',
                style: TextStyle(
                  color: Colors.grey,
                ),),
            ),
            SizedBox(height: Dimensions.height20),
            Wrap(
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: Dimensions.radius30,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(signUpIcons[index]),
                ),
              ),),
            ),
          ],
        ),
      ),
    );
  }
}

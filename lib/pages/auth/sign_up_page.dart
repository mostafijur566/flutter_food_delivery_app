import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/utils/colors.dart';
import 'package:flutter_food_delivery_app/utils/dimensions.dart';
import 'package:flutter_food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    String email;
    String password;

    var signUpIcons = [
      'assets/images/twitter.png',
      'assets/images/facebook.png',
      'assets/images/google.png',
    ];

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
              onTap: () async{
                email = emailController.text;
                password = passwordController.text;
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword
                    (email: email, password: password);

                  if(newUser != null)
                    {
                      print('Successful');
                    }

                } catch (e) {
                  print(e);
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
                  ),),
            ),
            SizedBox(height: Dimensions.height20),
            RichText(
              text: TextSpan(
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

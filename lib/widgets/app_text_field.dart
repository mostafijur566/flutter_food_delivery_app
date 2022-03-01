import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    Key? key,
    required this.emailController,
    required this.hintText,
    required this.icon,
    this.hideText = false,
    this.errorText
  }) : super(key: key);

  final TextEditingController emailController;
  final String hintText;
  final IconData icon;
  final bool hideText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.height20,
          right: Dimensions.height20
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: Offset(1, 10),
                color: Colors.grey.withOpacity(0.2)
            ),
          ],
          borderRadius: BorderRadius.circular(Dimensions.radius30)
      ),
      child: TextField(
        obscureText: hideText,
        controller: emailController,
        decoration: InputDecoration(
          errorText: errorText,
          hintText: hintText,
          prefixIcon: Icon(icon,
            color: AppColors.mainColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            borderSide: BorderSide(
                width: 1.0,
                color: Colors.white
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            borderSide: BorderSide(
                width: 1.0,
                color: Colors.white
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
          ),
        ),
      ),
    );
  }
}

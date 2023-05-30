import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merriage_management/Utils/app_colors.dart';
import 'package:merriage_management/Utils/btn.dart';
import 'package:merriage_management/Utils/dimensions.dart';
import 'package:merriage_management/Utils/spaces.dart';
import 'package:merriage_management/Utils/text_edit_field.dart';

import '../../../Utils/toast.dart';
import '../../HomeModule/Views/home_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool emailValid = false;
  bool passwordValid = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double blur = loading?5:0;
    return SafeArea(
      child: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: blur,sigmaY: blur),
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          height: 220,
                          "assets/Images/logo.jpg",
                        ),
                        AddVerticalSpace(30),
                        TextEditField(
                          hintText: "Email",
                          prefixIcon: Icons.email,
                          hintcolor: emailValid ? AppColors.red : AppColors.grey,
                          textEditingController: email,
                          width: Dimensions.screenWidth(context),
                        ),
                        AddVerticalSpace(16),
                        TextEditField(
                          hintText: "Password",
                          prefixIcon: Icons.lock,
                          isPassword: true,
                          textEditingController: password,
                          hintcolor: passwordValid ? AppColors.red : AppColors.grey,
                          width: Dimensions.screenWidth(context),
                        ),
                        AddVerticalSpace(50),
                        BTN(
                          title: "Sign In",
                          color: AppColors.black,
                          textColor: AppColors.white,
                          onPressed: () async {
                            setState(() {
                              loading =true;
                              if (email.text.isEmpty) {
                                emailValid = true;
                              } else if (password.text.isEmpty) {
                                passwordValid = true;
                              }
                            });
                            if (email.text.isNotEmpty && password.text.isNotEmpty) {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email.text, password: password.text).then((value) {
                                  Get.offAll(
                                    HomeView(),
                                    transition: Transition.rightToLeft,
                                    duration: Duration(milliseconds: 600),
                                  );
                                });
                              } on FirebaseAuthException catch (e) {
                                print(e.code);
                                if (e.code == 'user-not-found') {
                                  FlutterErrorToast(error: "Invalid Email");
                                } else if (e.code == 'wrong-password') {
                                  FlutterErrorToast(error: "Invalid Password");
                                }

                                setState(() {
                                  loading = false;
                                  // email.text = "";
                                  // password.text = "";
                                });
                              }
                            }
                          },
                          width: Dimensions.screenWidth(context) - 100,
                        ),
                        AddVerticalSpace(80),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          loading
              ? Container(
            height: Dimensions.screenHeight(context),
            width: Dimensions.screenWidth(context),
            color: AppColors.white.withOpacity(0.2),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.black,
              ),
            ),
          )
              : SizedBox()
        ],
      ),
    );
  }
}

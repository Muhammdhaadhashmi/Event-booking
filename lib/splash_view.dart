import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merriage_management/Utils/spaces.dart';
import 'package:merriage_management/Utils/text_view.dart';

import 'ApplicationModules/AuthenticationModule/Views/sign_in_view.dart';
import 'ApplicationModules/HomeModule/Views/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      if(FirebaseAuth.instance.currentUser!=null){
        Get.offAll(
          HomeView(),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 600),
        );
      }else{
        Get.offAll(
          SignInView(),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 600),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 100,
              right: 0,
              left: 0,
              child: Image.asset(
                "assets/Images/logo.jpg",
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  TextView(text: "Developed by"),
                  AddVerticalSpace(2),
                  Image.asset(
                    height: 80,
                    "assets/Images/splash.jpg",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

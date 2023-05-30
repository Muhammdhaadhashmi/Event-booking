import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:merriage_management/Utils/text_edit_field.dart';

import '../../../../Utils/app_colors.dart';
import '../../../../Utils/dimensions.dart';
import '../../../../Utils/spaces.dart';
import '../../../../Utils/text_view.dart';
import '../../../AuthenticationModule/Views/sign_in_view.dart';

class SettingListItem extends StatefulWidget {
  final itemData;

  SettingListItem({super.key, required this.itemData});

  @override
  State<SettingListItem> createState() => _SettingListItemState();
}

class _SettingListItemState extends State<SettingListItem> {
  String userName = "";
  TextEditingController fbrTax = TextEditingController();
  TextEditingController praTax = TextEditingController();

  getCurrentUserAndTax() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      userName = (value.data() as dynamic)["name"];
    });

    await FirebaseFirestore.instance
        .collection("taxRates")
        .doc("FBR")
        .get()
        .then((value) {
      fbrTax.text = (value.data() as dynamic)["percent"].toString();
    });

    await FirebaseFirestore.instance
        .collection("taxRates")
        .doc("PRA")
        .get()
        .then((value) {
      praTax.text = (value.data() as dynamic)["percent"].toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserAndTax();
  }

  showProfile() {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
          height: Dimensions.screenHeight(context),
          width: Dimensions.screenWidth(context),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Material(
              child: Container(
                height: 240,
                width: Dimensions.screenWidth(context) - 100,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: AppColors.grey, blurRadius: 4)
                ], color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "Profile",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    AddVerticalSpace(20),
                    TextView(
                      text: "Name : ${userName}",
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                    ),
                    TextView(
                      text:
                          "Email : ${FirebaseAuth.instance.currentUser!.email}",
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.start,
                    ),
                    AddVerticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: TextView(
                            text: "Ok",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }

  showTax() {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
          height: Dimensions.screenHeight(context),
          width: Dimensions.screenWidth(context),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Material(
              child: Container(
                height: 320,
                width: Dimensions.screenWidth(context) - 100,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: AppColors.grey, blurRadius: 4)
                ], color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "Tax",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    AddVerticalSpace(10),
                    TextView(
                      text: "FBR",
                      textAlign: TextAlign.start,
                    ),
                    AddVerticalSpace(5),
                    TextEditField(
                        hintText: "Tax",
                        prefixIcon: Icons.percent,
                        textEditingController: fbrTax,
                        width: Dimensions.screenWidth(context) - 140),
                    AddVerticalSpace(10),
                    TextView(
                      text: "FBR",
                      textAlign: TextAlign.start,
                    ),
                    AddVerticalSpace(5),
                    TextEditField(
                        hintText: "Tax",
                        prefixIcon: Icons.percent,
                        textEditingController: praTax,
                        width: Dimensions.screenWidth(context) - 140),
                    AddVerticalSpace(10),
                    // TextView(
                    //   text:
                    //       "Email : ${FirebaseAuth.instance.currentUser!.email}",
                    //   fontSize: 20,
                    //   fontWeight: FontWeight.w400,
                    //   textAlign: TextAlign.start,
                    // ),
                    AddVerticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: TextView(
                            text: "Cancel",
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("taxRates")
                                .doc("FBR")
                                .update({"percent": int.parse(fbrTax.text)});

                            await FirebaseFirestore.instance
                                .collection("taxRates")
                                .doc("PRA")
                                .update({"percent": int.parse(praTax.text)});
                            Navigator.pop(context);

                          },
                          child: TextView(
                            text: "Update",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // FirebaseAuth.instance
        //     .signInWithEmailAndPassword(email: 'newyou@domain.example', password: '123456'
        //        )
        //     .then((userCredential) {
        //   userCredential.user!.updateEmail("manager1@gmail.com");
        //   // userCredential.user!.updatePassword('newyou@domain.example');
        // });

        if (widget.itemData["title"] == "Profile") {
          showProfile();
        } else if (widget.itemData["title"] == "Tax Rates") {
          showTax();
        } else {
          await FirebaseAuth.instance.signOut();
          Get.offAll(
            SignInView(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 600),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        height: 70,
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: AppColors.grey, blurRadius: 4, offset: Offset(0, 4))
            ]
            // border: Border.all(color: AppColors.black, width: 2),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddHorizontalSpace(20),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    widget.itemData["icon"],
                  ),
                ),
              ),
            ),
            AddHorizontalSpace(10),
            TextView(
              text: widget.itemData["title"],
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}

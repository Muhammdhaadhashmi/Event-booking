import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/spaces.dart';
import '../../../Utils/text_view.dart';
import '../../../Utils/token.dart';
import '../../SettingModule/Views/setting_view.dart';
import '../datesscreen.dart';
import 'Components/image_list_item.dart';
import 'Components/selection_btn.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List images = [
    "https://images.unsplash.com/photo-1502635385003-ee1e6a1a742d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8d2VkZGluZ3xlbnwwfDF8MHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1523438885200-e635ba2c371e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8d2VkZGluZ3xlbnwwfDF8MHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1607190074257-dd4b7af0309f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8d2VkZGluZ3xlbnwwfDF8MHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1525258946800-98cfd641d0de?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHdlZGRpbmd8ZW58MHwxfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1535185384036-28bbc8035f28?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHdlZGRpbmd8ZW58MHwxfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1561593367-66c79c2294e6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDZ8fHdlZGRpbmd8ZW58MHwxfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1530023367847-a683933f4172?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTF8fHdlZGRpbmd8ZW58MHwxfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1562249004-1f7289c19c49?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTZ8fHdlZGRpbmd8ZW58MHwxfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1562249004-1f7289c19c49?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTZ8fHdlZGRpbmd8ZW58MHwxfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1558929992-f57215da003e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NjZ8fHdlZGRpbmd8ZW58MHwxfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
  ];

  List homeList = [
    {
      "title": "Add Entry",
      "icon": "assets/Images/photography.png",
    },
    {
      "title": "History",
      "icon": "assets/Images/invoice.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: Dimensions.screenHeight(context),
          width: Dimensions.screenWidth(context),
          child: Stack(
            children: [
              Container(
                height: Dimensions.screenHeight(context),
                width: Dimensions.screenWidth(context),
                child: ImageSlideshow(
                  // height: Dimensions.screenHeight(context) / 1.6,
                  // width: Dimensions.screenWidth(context),
                  children: images
                      .map(
                        (e) => ImageListItem(
                          image: e,
                          height: Dimensions.screenHeight(context) / 1.6,
                          width: Dimensions.screenWidth(context),
                        ),
                      )
                      .toList(),
                  initialPage: 0,
                  indicatorColor: AppColors.transparent,
                  indicatorBackgroundColor: AppColors.transparent,
                  autoPlayInterval: 8000,
                  isLoop: true,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: Dimensions.screenHeight(context),
                  width: Dimensions.screenWidth(context),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.black.withOpacity(0.6),
                        AppColors.white.withOpacity(0.3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 120,
                    width: Dimensions.screenWidth(context),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    // color: AppColors.pink,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.5,
                        // mainAxisExtent: 150,
                      ),
                      itemCount: homeList.length,
                      itemBuilder: (context, index) {
                        return SelectionBTN(
                          itemData: homeList[index],
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        SettingView(),
                        transition: Transition.rightToLeft,
                        duration: Duration(milliseconds: 600),
                      );
                    },
                    child: Container(
                      height: 65,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: Dimensions.screenWidth(context),
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   height: 38,
                          //   width: 38,
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //       image: AssetImage(
                          //         "assets/Images/settings.png",
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // AddHorizontalSpace(10),
                          TextView(
                            text: "Settings",
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AddVerticalSpace(50),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 120,
                    width: Dimensions.screenWidth(context),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    // color: AppColors.pink,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.5,
                        // mainAxisExtent: 150,
                      ),
                      itemCount: homeList.length,
                      itemBuilder: (context, index) {
                        return SelectionBTN(
                          itemData: homeList[index],
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        SettingView(),
                        transition: Transition.rightToLeft,
                        duration: Duration(milliseconds: 600),
                      );
                    },
                    child: Container(
                      height: 65,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: Dimensions.screenWidth(context),
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   height: 38,
                          //   width: 38,
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //       image: AssetImage(
                          //         "assets/Images/settings.png",
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // AddHorizontalSpace(10),
                          TextView(
                            text: "Settings",
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AddVerticalSpace(10),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(
                  //       DatesScreen(),
                  //       transition: Transition.rightToLeft,
                  //       duration: Duration(milliseconds: 500),
                  //     );
                  //   },
                  //   child: Container(
                  //     height: 70,
                  //     margin: EdgeInsets.symmetric(horizontal: 20),
                  //     width: Dimensions.screenWidth(context),
                  //     decoration: BoxDecoration(
                  //         color: AppColors.black,
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         // Container(
                  //         //   height: 38,
                  //         //   width: 38,
                  //         //   decoration: BoxDecoration(
                  //         //     image: DecorationImage(
                  //         //       image: AssetImage(
                  //         //         "assets/Images/settings.png",
                  //         //       ),
                  //         //     ),
                  //         //   ),
                  //         // ),
                  //         // AddHorizontalSpace(10),
                  //         TextView(
                  //           text: "Dates",
                  //           color: AppColors.white,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  AddVerticalSpace(50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

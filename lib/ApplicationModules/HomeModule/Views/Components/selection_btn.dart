import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merriage_management/ApplicationModules/HistoryModule/Views/history_view.dart';

import '../../../../Utils/app_colors.dart';
import '../../../../Utils/spaces.dart';
import '../../../../Utils/text_view.dart';
import '../../../EnteryModule/Views/add_entry_view.dart';

class SelectionBTN extends StatefulWidget {
  final itemData;

  const SelectionBTN({
    super.key,
    required this.itemData,
  });

  @override
  State<SelectionBTN> createState() => _SelectionBTNState();
}

class _SelectionBTNState extends State<SelectionBTN> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.itemData["title"] == "Add Entry") {
          Get.to(
            AddEnteryView(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 600),
          );
        } else {
          Get.to(
            HistoryView(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 600),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(5),
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(color: AppColors.black, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   height: 40,
            //   width: 40,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(
            //         widget.itemData["icon"],
            //       ),
            //     ),
            //   ),
            // ),
            TextView(
              text: widget.itemData["title"],
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            // AddHorizontalSpace(1),
          ],
        ),
      ),
    );
  }
}

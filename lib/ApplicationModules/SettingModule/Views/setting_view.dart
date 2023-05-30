import 'package:flutter/material.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/text_view.dart';
import 'Components/setting_list_item.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  List settings = [
    {
      "title": "Profile",
      "icon": "assets/Images/profile.png",
    },
    {
      "title": "Tax Rates",
      "icon": "assets/Images/taxes.png",
    },
    {
      "title": "Log out",
      "icon": "assets/Images/logout.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: TextView(text: "Settings"),
      ),
      body: ListView.builder(
        itemCount: settings.length,
        itemBuilder: (context, index) {
          return SettingListItem(itemData: settings[index]);
        },
      ),
    );
  }
}

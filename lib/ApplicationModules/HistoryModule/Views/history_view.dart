import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merriage_management/ApplicationModules/EnteryModule/Models/entry_model.dart';
import 'package:merriage_management/ApplicationModules/HistoryModule/ViewModels/history_view_model.dart';
import 'package:merriage_management/Utils/dimensions.dart';
import 'package:merriage_management/Utils/spaces.dart';
import 'package:merriage_management/Utils/text_edit_field.dart';

import '../../../Utils/app_colors.dart';
import '../../../Utils/search_text_field.dart';
import '../../../Utils/text_view.dart';
import 'Components/history_list_item.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView>
    with TickerProviderStateMixin {
  HistoryViewModel historyViewModel = Get.put(HistoryViewModel());
  List<Widget> Categoty = [
    Tab(child: TextView(text: "All")),
    Tab(child: TextView(text: "Lawn")),
    Tab(child: TextView(text: "Hall")),
    Tab(child: TextView(text: "Marquee")),
  ];
  List Cat = [
    "All",
    "Lawn",
    "Hall",
    "Marquee",
  ];
  TabController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  bool isSearch = false;
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: isSearch
            ? TextEditField(
                hintText: "Search",
                textEditingController: search,
                prefixIcon: Icons.search,
                width: Dimensions.screenWidth(context) - 100,
                onChanged: (value) {
                  historyViewModel.searchRes.value = value;
                  historyViewModel.getHistory();
                },
              )
            : TextView(text: "History"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
            icon: Icon(isSearch ? Icons.cancel_outlined : Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddVerticalSpace(10),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  TabBar(
                    isScrollable: true,
                    // physics: BouncingScrollPhysics(),
                    indicatorColor: AppColors.black,
                    controller: controller,
                    unselectedLabelColor: AppColors.black,
                    unselectedLabelStyle: TextStyle(color: AppColors.black),
                    indicator: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    tabs: Categoty,
                    onTap: (value) {
                      if (Cat[value] != "All") {
                        historyViewModel.searchRes.value = Cat[value];
                        historyViewModel.getHistory();
                      } else {
                        historyViewModel.searchRes.value = '';
                        historyViewModel.getHistory();
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: FutureBuilder(
                  future: historyViewModel.getHistory(),
                  builder: (context, snapshot) {


                    return Obx(() => ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: historyViewModel.historyList.value.length,
                          padding: EdgeInsets.only(top: 16),
                          itemBuilder: (context, index) {
                            var data =
                                historyViewModel.historyList.value[index];
                            return HistoryListItem(
                              entryModel: EntryModel(
                                Lawn: data.Lawn,
                                foodBill: data.foodBill,
                                entryID: data.entryID,
                                enteredBy: data.enteredBy,
                                description: data.description,
                                perHeadPrice: data.perHeadPrice,
                                partyName: data.partyName,
                                noOfGuests: data.noOfGuests,
                                maleGuests: data.maleGuests,
                                femaleGuests: data.femaleGuests,
                                tax: data.tax,
                                amount: data.amount,
                                flowerDecoration: data.flowerDecoration,
                                soundSystem: data.soundSystem,
                                generator: data.generator,
                                discount: data.discount,
                                totalAmount: data.totalAmount,
                                advance: data.advance,
                                remaining: data.remaining,
                                images: data.images,
                                lumsumGuests: data.lumsumGuests,
                                hallType: data.hallType,
                                time: data.time,
                                eventDate: data.eventDate,
                                eventName: data.eventName,
                                perHead: data.perHead,
                                waiterChargesPrice: data.waiterChargesPrice,
                                taxType: data.taxType,
                                fanQuantity: data.fanQuantity,
                                fanPrice: data.fanPrice,
                                acQuantity: data.acQuantity,
                                acPrice: data.acPrice,
                                acTotal: data.acTotal,
                                fanTotal: data.fanTotal,
                                partyCNIC: data.partyCNIC,
                                partyNumber: data.partyNumber,
                                partyAddress: data.partyAddress,
                              ),
                            );
                          },
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

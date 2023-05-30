import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:merriage_management/ApplicationModules/EnteryModule/Models/entry_model.dart';
import 'package:merriage_management/Utils/app_colors.dart';
import 'package:merriage_management/Utils/dimensions.dart';
import 'package:merriage_management/Utils/spaces.dart';
import 'package:merriage_management/Utils/text_view.dart';

import '../../../../Utils/toast.dart';
import '../../../EnteryModule/ViewModels/entry_view_model.dart';
import '../../../InvoiceModule/Views/invoice_view.dart';
import '../deleteimages.dart';
import '../edit_entry_view.dart';

class HistoryListItem extends StatefulWidget {
  final EntryModel entryModel;

  const HistoryListItem({super.key, required this.entryModel});

  @override
  State<HistoryListItem> createState() => _HistoryListItemState();
}

class _HistoryListItemState extends State<HistoryListItem> {
  EntryViewModel entryViewModel = Get.put(EntryViewModel());
  String selectedTime = '';
  List<String> time = [
    "Day",
    "Night",
  ];

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          InVoiceView(entryModel: widget.entryModel),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 600),
        );
      },
      child: Container(
        // height: 100,
        width: Dimensions.screenWidth(context),
        margin: EdgeInsets.only(bottom: 10, right: 16, left: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    Get.to(
                      EditEnteryView(entryModel: widget.entryModel),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 600),
                    );
                  },
                  child: Icon(
                    Icons.edit_note_sharp,
                    // color: AppColors.red,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // await FirebaseFirestore.instance
                    //     .collection("bookings")
                    //     .doc("${widget.entryModel.entryID}")
                    //     .delete()
                    //     .then((value) {
                    //   print("deleted");
                    // });
                  },
                 child: ElevatedButton.icon(
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.red,
                   ),
                    onPressed: () async{
                      await FirebaseFirestore.instance
                          .collection("bookings")
                          .doc("${widget.entryModel.entryID}")
                          .delete()
                          .then((value) {
                        print("deleted");
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ), label: Text("Delete Record"),
                ),
                )
              ],
            ),
            AddVerticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Invoice Id",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                TextView(
                  text: "${widget.entryModel.entryID}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Type",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                TextView(
                  text: "${widget.entryModel.hallType}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Event Name",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                TextView(
                  text: "${widget.entryModel.eventName}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Party Name",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                Container(
                  width: 200,
                  child: TextView(
                    text: "${widget.entryModel.partyName}",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,

                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Total Amount",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                TextView(
                  text: "${widget.entryModel.totalAmount.ceil()}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Advance",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                TextView(
                  text: "${widget.entryModel.advance.ceil()}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Remaining Amount",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                TextView(
                  text: "${widget.entryModel.remaining.ceil()}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Time",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                TextView(
                  text: "${widget.entryModel.time}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Event Date",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                TextView(
                  text:
                      "${DateFormat.yMMMd().format(DateTime.fromMicrosecondsSinceEpoch(widget.entryModel.eventDate))}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Entered by",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.grey,
                ),
                TextView(
                  text: "${widget.entryModel.enteredBy}",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.black,
                ),
              ],
            ),
            AddVerticalSpace(10),
               GestureDetector(
                  onTap: () async {
                    // await FirebaseFirestore.instance
                    //     .collection("bookings")
                    //     .doc("${widget.entryModel.entryID}")
                    //     .delete()
                    //     .then((value) {
                    //   print("deleted");
                    // });
                  },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  <Widget>[
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red
                            ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteImages(entryModel: widget.entryModel)));
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),

                              label: Text("Delete Images",)),
                          // Expanded(
                          //   child: Text(
                          //     'on the right hand corner to start a new chat.',
                          //     style: TextStyle(
                          //       fontSize: 17,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  )
                // child: IconButton(
                //   onPressed: (){}, icon: Icon(Icons.delete),
                //
                // ),
                // child: Icon(
                //   Icons.delete,
                //   color: AppColors.red,
                // ),
          ],

        ),

      ),

    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../EnteryModule/Models/entry_model.dart';

class HistoryViewModel extends GetxController {
  RxList<EntryModel> historyList = <EntryModel>[].obs;
  RxList<EntryModel> list = <EntryModel>[].obs;
  RxString searchRes = "".obs;

  getHistory() async {
    await FirebaseFirestore.instance
        .collection("bookings")
        .orderBy("entryID", descending: true)
        .snapshots()
        .listen((event) {
      historyList.value = EntryModel.jsonToListView(event.docs)
          .where(
            (element) =>
        (FirebaseAuth.instance.currentUser!.email == "superadmin@gmail.com"
            ? true
            : element.enteredBy ==
            FirebaseAuth.instance.currentUser!.email!) &&
            (element.hallType
                .toLowerCase()
                .contains(searchRes.value.toLowerCase()) ||
                element.eventName
                    .toLowerCase()
                    .contains(searchRes.value.toLowerCase()) ||
                element.partyName
                    .toLowerCase()
                    .contains(searchRes.value.toLowerCase()) ||
                element.enteredBy
                    .toLowerCase()
                    .contains(searchRes.value.toLowerCase()) ||
                DateFormat.yMMMd().format(DateTime.fromMicrosecondsSinceEpoch(element.eventDate))
                    .toLowerCase()
                    .contains(searchRes.value.toLowerCase()) ||
                element.time
                    .toLowerCase()
                    .contains(searchRes.value.toLowerCase())),
      )
          .toList();
    });
  }
}

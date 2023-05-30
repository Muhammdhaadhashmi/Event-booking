// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:intl/intl.dart';
//
// import '../../Utils/app_colors.dart';
// import '../../Utils/btn.dart';
// import '../../Utils/dimensions.dart';
// import '../../Utils/spaces.dart';
// import '../../Utils/text_edit_field.dart';
// import '../../Utils/text_view.dart';
// import '../EnteryModule/Models/entry_model.dart';
// import '../EnteryModule/ViewModels/entry_view_model.dart';
// import '../InvoiceModule/Views/invoice_view.dart';
//
// class DatesScreen extends StatefulWidget {
//
//
//   DatesScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DatesScreen> createState() => _DatesScreenState();
// }
//
// class _DatesScreenState extends State<DatesScreen> {
//   TextEditingController fromdate = TextEditingController();
//   TextEditingController todate = TextEditingController();
//
//   bool FromDateValid = false;
//   bool ToDateValid = false;
//
//   // EntryViewModel entryViewModel = Get.put(EntryViewModel());
//   List<DateTime?> dates = [];
//   RxList<EntryModel> entryList = <EntryModel>[].obs;
//   List list = [];
//   double Tax = 0;
//   String selectedTax = '';
//   List tax = [
//     "FBR",
//     "PRA",
//     "Both",
//   ];
//
//   String selectedType = '';
//   List type = [
//     "Lawn",
//     "Hall",
//     "Marquee",
//   ];
//
//   String selectedLawn = '';
//   List lawns = [
//     "Lawn A",
//     "Lawn B",
//     "Lawn C",
//     "Lawn D",
//     "Lawn E",
//     "Lawn F",
//   ];
//
//   String selectedTime = '';
//   List<String> time = [
//     "Day",
//     "Night",
//   ];
//
//   bool partyNameValid = false;
//   bool noOfCustomerValid = false;
//   bool maleCustomerValid = false;
//   bool femaleCustomerValid = false;
//
//   bool bookingDateValid = false;
//   bool eventNameValid = false;
//   bool lumSumCustomerValid = false;
//   bool waiterChargesPriceValid = false;
//   bool partyNumberValid = false;
//   bool partyCNICValid = false;
//   bool partyAddressValid = false;
//   bool perHeadValid = false;
//
//   // bool taxValid = false;
//   bool flowerDecorationValid = false;
//   bool soundSystemValid = false;
//   bool fanValid = false;
//   bool acValid = false;
//   bool generatorValid = false;
//   bool amountValid = false;
//   bool discountValid = false;
//   bool totalAmountValid = false;
//   bool givenAmountValid = false;
//   bool returnAmountValid = false;
//
//   bool typeValid = false;
//   bool taxValid = false;
//   bool loading = false;
//
//
//   TextEditingController partyName = TextEditingController();
//   TextEditingController partyNumber = TextEditingController();
//   TextEditingController partyCNIC = TextEditingController();
//   TextEditingController partyAddress = TextEditingController();
//   TextEditingController noOfCustomer = TextEditingController();
//   TextEditingController maleCustomer = TextEditingController();
//   TextEditingController femaleCustomer = TextEditingController();
//
//   // TextEditingController tax = TextEditingController();
//   TextEditingController flowerDecoration = TextEditingController();
//   TextEditingController foodBill = TextEditingController();
//   TextEditingController soundSystem = TextEditingController();
//   TextEditingController generator = TextEditingController();
//   TextEditingController amount = TextEditingController();
//   TextEditingController discount = TextEditingController();
//   TextEditingController taxPrice = TextEditingController();
//   TextEditingController totalAmount = TextEditingController();
//   TextEditingController Advance = TextEditingController();
//   TextEditingController Remaining = TextEditingController();
//   TextEditingController bookingDate = TextEditingController();
//   TextEditingController eventName = TextEditingController();
//   TextEditingController lumSumCustomer = TextEditingController();
//   TextEditingController waiterCharges = TextEditingController(text: "0");
//   TextEditingController perHead = TextEditingController();
//   TextEditingController fanQuantity = TextEditingController();
//   TextEditingController fanPrice = TextEditingController();
//   TextEditingController acHour = TextEditingController();
//   TextEditingController acPrice = TextEditingController();
//   TextEditingController acTotal = TextEditingController();
//   TextEditingController fanTotal = TextEditingController();
//   TextEditingController description = TextEditingController();
//
//
//   int customerPrice = 0;
//
//   EntryViewModel entryViewModel = Get.put(EntryViewModel());
//   String emailCreatedby = "";
//   bool isdata = false;
//   Future<String> getData() async{
//     int second = 1676660400000000;
//     await FirebaseFirestore.instance
//         .collection('bookings')
//         .where("eventDate", isGreaterThan: second)
//     //.where("eventDate", isGreaterThan: first)
//         .snapshots().listen((event) {
//       event.docs.forEach((element) {
//         emailCreatedby = element['enteredBy'];
//         print("My data "+element['enteredBy']);
//         isdata = true;
//       });
//       //no data show bro
//
//       //not showing  inthe app
//
//     });
//     return emailCreatedby;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     // double blur = loading ? 5 : 0;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.black,
//         title: TextView(text: "Select Dates"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AddVerticalSpace(20),
//               TextView(text: "From"),
//               AddVerticalSpace(10),
//               TextEditField(
//                 hintText: "Select from Date",
//                 readOnly: true,
//                 prefixIcon: Icons.calendar_month,
//                 textEditingController: fromdate,
//                 hintcolor: FromDateValid ? AppColors.red : AppColors.grey,
//                 width: Dimensions.screenWidth(context),
//                 onTap: () {
//                   Fromdate(context);
//                 },
//               ),
//               AddVerticalSpace(10),
//               TextView(text: "To"),
//               AddVerticalSpace(10),
//               TextEditField(
//                 hintText: "Select to Date",
//                 readOnly: true,
//                 prefixIcon: Icons.calendar_month,
//                 textEditingController: todate,
//                 hintcolor: ToDateValid ? AppColors.red : AppColors.grey,
//                 width: Dimensions.screenWidth(context),
//                 onTap: () {
//                   Todate(context);
//                 },
//               ),
//               AddVerticalSpace(20),
//               BTN(
//                 title: "Done",
//                 color: AppColors.black,
//                 textColor: AppColors.white,
//                 onPressed: () async {
//                   int first = 1676833200000000;
//                   int second = 1676660400000000;
//                   var response = await FirebaseFirestore.instance
//                       .collection('bookings')
//                       .where("eventDate", isGreaterThan: second)
//                   //.where("eventDate", isGreaterThan: first)
//                       .snapshots().listen((event) {
//                     event.docs.forEach((element) {
//                       emailCreatedby = element['enteredBy'];
//                       print("My data "+element['enteredBy']);
//                       isdata = true;
//                     });
//                     //no data show bro
//
//                     //not showing  inthe app
//
//                   });
//                   //.get();
//                   //     .then((value) {
//                   //       //give me a moment
//                   //
//                   // where is the date string?
//                   //   print(value.documents);
//                   // }).catchError((onError) => print('error test 1 ' + onError.toString()));
//                   //response.
//                   //print(response.docs);
//
//                 },
//                 width: Dimensions.screenWidth(context),
//               ),
//               FutureBuilder(
//                   future: getData(),
//                   builder: (context,snap){
//                     if(snap.hasData){
//                       return Text(snap.data.toString());
//                     }
//                     return CircularProgressIndicator();
//                   }),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Fromdate(context) {
//     showAnimatedDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return Container(
//             height: Dimensions.screenHeight(context),
//             width: Dimensions.screenWidth(context),
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Center(
//               child: Material(
//                 child: CalendarDatePicker2WithActionButtons(
//                     config: CalendarDatePicker2WithActionButtonsConfig(
//                       calendarType: CalendarDatePicker2Type.single,
//                       selectedDayHighlightColor: AppColors.mainColor,
//                     ),
//                     onCancelTapped: () {
//                       Navigator.pop(context);
//                     },
//                     initialValue: dates.length != 0 ? dates : [],
//                     onValueChanged: (dates) async {
//                       if (dates.isNotEmpty) {
//                         setState(() {
//                           this.dates = dates;
//                           fromdate.text =
//                               DateFormat.yMMMMEEEEd().format(dates[0]!);
//                         });
//                         Navigator.pop(context);
//                       }
//                     }),
//               ),
//             ));
//       },
//       animationType: DialogTransitionType.size,
//       curve: Curves.fastOutSlowIn,
//       duration: Duration(seconds: 1),
//     );
//   }
//
//   Todate(context) {
//     showAnimatedDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return Container(
//             height: Dimensions.screenHeight(context),
//             width: Dimensions.screenWidth(context),
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Center(
//               child: Material(
//                 child: CalendarDatePicker2WithActionButtons(
//                     config: CalendarDatePicker2WithActionButtonsConfig(
//                       calendarType: CalendarDatePicker2Type.single,
//                       selectedDayHighlightColor: AppColors.mainColor,
//                     ),
//                     onCancelTapped: () {
//                       Navigator.pop(context);
//                     },
//                     initialValue: dates.length != 0 ? dates : [],
//                     onValueChanged: (dates) async {
//                       if (dates.isNotEmpty) {
//                         setState(() {
//                           this.dates = dates;
//                           todate.text =
//                               DateFormat.yMMMMEEEEd().format(dates[0]!);
//                         });
//                         Navigator.pop(context);
//                       }
//                     }),
//               ),
//             ));
//       },
//       animationType: DialogTransitionType.size,
//       curve: Curves.fastOutSlowIn,
//       duration: Duration(seconds: 1),
//     );
//   }
//
// }

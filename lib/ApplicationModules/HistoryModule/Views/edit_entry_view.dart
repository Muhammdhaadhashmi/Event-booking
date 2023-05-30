import 'dart:io';
import 'dart:ui';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:merriage_management/ApplicationModules/EnteryModule/Models/entry_model.dart';
import 'package:merriage_management/Utils/app_colors.dart';
import 'package:merriage_management/Utils/dimensions.dart';
import 'package:merriage_management/Utils/spaces.dart';
import 'package:merriage_management/Utils/text_edit_field.dart';
import 'package:merriage_management/Utils/text_view.dart';
import 'package:merriage_management/Utils/toast.dart';
import '../../../Utils/btn.dart';
import '../../EnteryModule/ViewModels/entry_view_model.dart';

class EditEnteryView extends StatefulWidget {
  final EntryModel entryModel;

  const EditEnteryView({super.key, required this.entryModel});

  @override
  State<EditEnteryView> createState() => _EditEnteryViewState();
}

class _EditEnteryViewState extends State<EditEnteryView> {
  TextEditingController partyName = TextEditingController();
  TextEditingController partyNumber = TextEditingController();
  TextEditingController partyCNIC = TextEditingController();
  TextEditingController partyAddress = TextEditingController();
  TextEditingController noOfCustomer = TextEditingController();
  TextEditingController maleCustomer = TextEditingController();
  TextEditingController femaleCustomer = TextEditingController();

  // TextEditingController tax = TextEditingController();
  TextEditingController flowerDecoration = TextEditingController();
  TextEditingController soundSystem = TextEditingController();
  TextEditingController generator = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController taxPrice = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  TextEditingController Advance = TextEditingController();
  TextEditingController Remaining = TextEditingController();
  TextEditingController bookingDate = TextEditingController();
  TextEditingController eventName = TextEditingController();
  TextEditingController lumSumCustomer = TextEditingController();
  TextEditingController waiterCharges = TextEditingController(text: "0");
  TextEditingController perHead = TextEditingController();
  TextEditingController fanQuantity = TextEditingController();
  TextEditingController fanPrice = TextEditingController();
  TextEditingController acHour = TextEditingController();
  TextEditingController acPrice = TextEditingController();
  TextEditingController acTotal = TextEditingController();
  TextEditingController fanTotal = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController foodBill = TextEditingController();

  bool partyNameValid = false;
  bool noOfCustomerValid = false;
  bool maleCustomerValid = false;
  bool femaleCustomerValid = false;

  bool bookingDateValid = false;
  bool eventNameValid = false;
  bool lumSumCustomerValid = false;
  bool waiterChargesPriceValid = false;
  bool partyNumberValid = false;
  bool partyCNICValid = false;
  bool partyAddressValid = false;
  bool perHeadValid = false;

  // bool taxValid = false;
  bool flowerDecorationValid = false;
  bool soundSystemValid = false;
  bool fanValid = false;
  bool acValid = false;
  bool generatorValid = false;
  bool amountValid = false;
  bool discountValid = false;
  bool totalAmountValid = false;
  bool givenAmountValid = false;
  bool returnAmountValid = false;

  bool typeValid = false;
  bool taxValid = false;
  bool loading = false;

  double Tax = 0;
  String selectedTax = '';
  List tax = [
    "FBR",
    "PRA",
    "Both",
  ];

  String selectedType = '';
  List type = [
    "Lawn",
    "Hall",
    "Marquee",
  ];

  String selectedLawn = '';
  List lawns = [
    "Lawn A",
    "Lawn B",
    "Lawn C",
    "Lawn D",
    "Lawn E",
    "Lawn F",
  ];

  String selectedTime = '';
  List<String> time = [
    "Day",
    "Night",
  ];

  int customerPrice = 0;

  EntryViewModel entryViewModel = Get.put(EntryViewModel());
  List<DateTime?> dates = [];

  @override
  void initState() {
    super.initState();

    entryViewModel.getEntryonDate();

    selectedType == widget.entryModel.hallType;
    selectedTime = widget.entryModel.time;
    selectedTax = widget.entryModel.taxType;
    dates = [DateTime.fromMicrosecondsSinceEpoch(widget.entryModel.eventDate)];
    bookingDate.text = bookingDate.text = DateFormat.yMMMMEEEEd().format(
        DateTime.fromMicrosecondsSinceEpoch(widget.entryModel.eventDate));

    eventName.text = widget.entryModel.eventName;
    partyName.text = widget.entryModel.partyName;
    partyNumber.text = widget.entryModel.partyNumber;
    partyCNIC.text = widget.entryModel.partyCNIC;
    partyAddress.text = widget.entryModel.partyAddress;
    noOfCustomer.text = widget.entryModel.noOfGuests.ceil().toString();
    maleCustomer.text = widget.entryModel.maleGuests.ceil().toString();
    femaleCustomer.text = widget.entryModel.femaleGuests.ceil().toString();
    lumSumCustomer.text = widget.entryModel.lumsumGuests.ceil().toString();
    perHead.text = widget.entryModel.perHead.ceil().toString();
    waiterCharges.text = widget.entryModel.waiterChargesPrice.ceil().toString();
    flowerDecoration.text =
        widget.entryModel.flowerDecoration.ceil().toString();
    soundSystem.text = widget.entryModel.soundSystem.ceil().toString();
    fanQuantity.text = widget.entryModel.fanQuantity.ceil().toString();
    fanPrice.text = widget.entryModel.fanPrice.ceil().toString();
    fanTotal.text = widget.entryModel.fanTotal.ceil().toString();
    acHour.text = widget.entryModel.acPrice.ceil().toString();
    acPrice.text = widget.entryModel.acPrice.ceil().toString();
    acTotal.text = widget.entryModel.acTotal.ceil().toString();
    generator.text = widget.entryModel.generator.ceil().toString();
    amount.text = widget.entryModel.amount.ceil().toString();
    taxPrice.text = widget.entryModel.tax.ceil().toString();
    discount.text = widget.entryModel.discount.ceil().toString();
    totalAmount.text = widget.entryModel.totalAmount.ceil().toString();
    Advance.text = widget.entryModel.advance.ceil().toString();
    Remaining.text = widget.entryModel.remaining.ceil().toString();
    description.text = widget.entryModel.description;
    selectedTime = widget.entryModel.time;
    selectedTax = widget.entryModel.taxType;
    selectedType = widget.entryModel.hallType;
    selectedLawn = widget.entryModel.Lawn ?? "";
    foodBill.text = widget.entryModel.foodBill.toString();
    entryViewModel.imagesURL.value = widget.entryModel.images;
    print(entryViewModel.imagesURL.value.length);
  }

  List list = [];

  showDialogView() {
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
              child: CalendarDatePicker2WithActionButtons(
                config: CalendarDatePicker2WithActionButtonsConfig(
                  calendarType: CalendarDatePicker2Type.single,
                  selectedDayHighlightColor: AppColors.mainColor,
                ),
                onCancelTapped: () {
                  Navigator.pop(context);
                },
                initialValue: dates.length != 0 ? dates : [],
                onValueChanged: (dates) async {
                  if (dates.isNotEmpty) {
                    setState(() {
                      this.dates = dates;
                      bookingDate.text =
                          DateFormat.yMMMMEEEEd().format(dates[0]!);
                    });

                    if (entryViewModel.entryList.value
                        .where((element) =>
                            element.eventDate ==
                            dates[0]!.microsecondsSinceEpoch)
                        .isNotEmpty) {
                      list = entryViewModel.entryList.value
                          .where((element) =>
                              element.eventDate ==
                              dates[0]!.microsecondsSinceEpoch)
                          .toList();

                      // type.removeWhere((element) =>
                      //     element ==
                      //     entryViewModel.entryList.value[0].hallType);

                      ////////////////////////////////////////////
                    }

                    Navigator.pop(context);
                  }
                },
                // onOkTapped: (){
                // },
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
    double blur = loading ? 5 : 0;
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.black,
              title: TextView(text: "Add Entery"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddVerticalSpace(20),
                    TextView(text: "Event Date"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Event Date",
                      readOnly: true,
                      prefixIcon: Icons.calendar_month,
                      textEditingController: bookingDate,
                      hintcolor:
                          bookingDateValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                      onTap: () {
                        showDialogView();
                      },
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Event Time"),
                    AddVerticalSpace(5),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: AppColors.grey, blurRadius: 0.5)
                          ]),
                      child: DropdownButtonFormField2(
                        buttonPadding: EdgeInsets.only(
                          right: 10,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: AppColors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.watch_later,
                                color: AppColors.white,
                              ),
                            ),
                            AddHorizontalSpace(10),
                            TextView(
                              text: widget.entryModel.time,
                              fontSize: 14,
                              color: taxValid ? AppColors.red : AppColors.grey,
                            ),
                          ],
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.grey,
                        ),
                        iconSize: 30,
                        buttonHeight: 55,
                        // buttonPadding:
                        // const EdgeInsets.only(left: 20, right: 10),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        items: time
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: AppColors.black,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.watch_later,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      AddHorizontalSpace(10),
                                      TextView(
                                        text: item,
                                        fontSize: 14,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select Days.';
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedTime = value!;
                          });
                          lawns = [
                            "Lawn A",
                            "Lawn B",
                            "Lawn C",
                            "Lawn D",
                            "Lawn E",
                            "Lawn F",
                          ];
                          type = [
                            "Lawn",
                            "Hall",
                            "Marquee",
                          ];
                          for (int i = 0; i < list.length; i++) {
                            if (list[i].time == selectedTime) {
                              if (list[i].hallType != "Lawn") {
                                type.removeWhere(
                                    (element) => element == list[i].hallType);
                              } else {
                                lawns.removeWhere(
                                    (element) => element == list[i].Lawn);
                              }
                            }
                          }

                          //Do something when changing the item if you want.
                        },
                      ),
                    ),
                    AddVerticalSpace(11),
                    TextView(text: " Select Lawn / Hall / Marquee"),
                    AddVerticalSpace(5),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: AppColors.grey, blurRadius: 0.5)
                          ]),
                      child: DropdownButtonFormField2(
                        buttonPadding: EdgeInsets.only(
                          right: 10,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: AppColors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.home,
                                color: AppColors.white,
                              ),
                            ),
                            AddHorizontalSpace(10),
                            TextView(
                              text: widget.entryModel.hallType,
                              fontSize: 14,
                              color: typeValid ? AppColors.red : AppColors.grey,
                            ),
                          ],
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.grey,
                        ),
                        iconSize: 30,
                        buttonHeight: 55,
                        // buttonPadding:
                        // const EdgeInsets.only(left: 20, right: 10),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        items: type
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: AppColors.black,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.home,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      AddHorizontalSpace(10),
                                      TextView(
                                        text: item,
                                        fontSize: 14,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select Days.';
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                          //Do something when changing the item if you want.
                        },
                      ),
                    ),

                    selectedType == "Lawn"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AddVerticalSpace(11),
                              TextView(text: "Select Lawns"),
                              AddVerticalSpace(5),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.grey,
                                          blurRadius: 0.5)
                                    ]),
                                child: DropdownButtonFormField2(
                                  buttonPadding: EdgeInsets.only(
                                    right: 10,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: AppColors.black,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.home,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      AddHorizontalSpace(10),
                                      TextView(
                                        text: widget.entryModel.Lawn,
                                        fontSize: 14,
                                        color: typeValid
                                            ? AppColors.red
                                            : AppColors.grey,
                                      ),
                                    ],
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.grey,
                                  ),
                                  iconSize: 30,
                                  buttonHeight: 55,
                                  // buttonPadding:
                                  // const EdgeInsets.only(left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: lawns
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  margin: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Icon(
                                                    Icons.home,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                                AddHorizontalSpace(10),
                                                TextView(
                                                  text: item,
                                                  fontSize: 14,
                                                  color: AppColors.black,
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select Days.';
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      selectedLawn = value!;
                                    });
                                    //Do something when changing the item if you want.
                                  },
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    AddVerticalSpace(11),
                    TextView(text: "Event Name"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Event Name",
                      prefixIcon: Icons.local_fire_department,
                      textEditingController: eventName,
                      hintcolor:
                          eventNameValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Party Name"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Party Name",
                      prefixIcon: Icons.person,
                      textEditingController: partyName,
                      hintcolor:
                          partyNameValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Party Mobile Number"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Party Mobile Number",
                      prefixIcon: Icons.phone,
                      inputType: TextInputType.number,
                      textEditingController: partyNumber,
                      hintcolor:
                          partyNumberValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Party CNIC"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Party CNIC",
                      prefixIcon: Icons.card_membership,
                      textEditingController: partyCNIC,
                      inputType: TextInputType.number,
                      hintcolor:
                          partyCNICValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Party Address"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Party Address",
                      prefixIcon: Icons.location_on,
                      textEditingController: partyAddress,
                      hintcolor:
                          partyAddressValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "No. of Guests"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "No. of Guests",
                      prefixIcon: Icons.person_add_alt_1,
                      textEditingController: noOfCustomer,
                      inputType: TextInputType.number,
                      hintcolor:
                          noOfCustomerValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                      onChanged: (value) {
                        if (value != "") {
                          int price =
                              (int.parse(perHead.text) * int.parse(value)) +
                                  int.parse(waiterCharges.text) +
                                  int.parse(flowerDecoration.text) +
                                  int.parse(soundSystem.text) +
                                  int.parse(fanTotal.text) +
                                  int.parse(acTotal.text) +
                                  int.parse(foodBill.text) +
                                  int.parse(taxPrice.text) +
                                  int.parse(generator.text);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        } else {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(value)) +
                              int.parse(waiterCharges.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(soundSystem.text) +
                              int.parse(fanTotal.text) +
                              int.parse(foodBill.text) +
                              int.parse(generator.text) +
                              int.parse(taxPrice.text) +
                              int.parse(acTotal.text);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        }
                      },
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Male & Female Guests"),
                    AddVerticalSpace(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextEditField(
                          hintText: "Male Guests",
                          prefixIcon: Icons.male,
                          inputType: TextInputType.number,
                          textEditingController: maleCustomer,
                          hintcolor: maleCustomerValid
                              ? AppColors.red
                              : AppColors.grey,
                          width: Dimensions.screenWidth(context) / 2.3,
                        ),
                        TextEditField(
                          hintText: "Female Guests",
                          prefixIcon: Icons.female,
                          inputType: TextInputType.number,
                          textEditingController: femaleCustomer,
                          hintcolor: femaleCustomerValid
                              ? AppColors.red
                              : AppColors.grey,
                          width: Dimensions.screenWidth(context) / 2.3,
                        ),
                      ],
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Lum Sum Guests"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Lum Sum Guests",
                      prefixIcon: Icons.male,
                      textEditingController: lumSumCustomer,
                      inputType: TextInputType.number,
                      hintcolor:
                          lumSumCustomerValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                    ),

                    AddVerticalSpace(11),
                    TextView(text: "Per Head"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Per Head",
                      prefixIcon: Icons.person_pin,
                      textEditingController: perHead,
                      inputType: TextInputType.number,
                      hintcolor:
                          lumSumCustomerValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                      onChanged: (value) {
                        if (value != "") {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(value)) +
                              int.parse(waiterCharges.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(soundSystem.text) +
                              int.parse(foodBill.text) +
                              int.parse(fanTotal.text) +
                              int.parse(acTotal.text) +
                              int.parse(taxPrice.text) +
                              int.parse(generator.text);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        } else {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(value)) +
                              int.parse(waiterCharges.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(soundSystem.text) +
                              int.parse(fanTotal.text) +
                              int.parse(generator.text) +
                              int.parse(foodBill.text) +
                              int.parse(taxPrice.text) +
                              int.parse(acTotal.text);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        }
                      },
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Waiter Charges"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Waiter Charges",
                      prefixIcon: Icons.home,
                      textEditingController: waiterCharges,
                      inputType: TextInputType.number,
                      hintcolor:
                          lumSumCustomerValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                      // onEditingComplete: () {
                      //   amount.text =
                      //       "${int.parse(waiterCharges.text) + int.parse(amount.text)}";
                      // },
                      onChanged: (value) {
                        if (value != "") {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(perHead.text)) +
                              int.parse(generator.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(soundSystem.text) +
                              int.parse(foodBill.text) +
                              int.parse(fanTotal.text) +
                              int.parse(taxPrice.text) +
                              int.parse(acTotal.text) +
                              int.parse(value);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        } else {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(perHead.text)) +
                              int.parse(generator.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(soundSystem.text) +
                              int.parse(fanTotal.text) +
                              int.parse(taxPrice.text) +
                              int.parse(foodBill.text) +
                              int.parse(acTotal.text);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        }
                      },
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Food Bill"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Food Bill",
                      prefixIcon: Icons.home,
                      textEditingController: foodBill,
                      inputType: TextInputType.number,
                      hintcolor:
                          lumSumCustomerValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                      onChanged: (value) {
                        if (value != "") {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(perHead.text)) +
                              int.parse(generator.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(soundSystem.text) +
                              int.parse(fanTotal.text) +
                              int.parse(taxPrice.text) +
                              int.parse(acTotal.text) +
                              int.parse(value);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        } else {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(perHead.text)) +
                              int.parse(generator.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(soundSystem.text) +
                              int.parse(fanTotal.text) +
                              int.parse(taxPrice.text) +
                              int.parse(acTotal.text);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        }
                      },

                      // onEditingComplete: () {
                      //   amount.text =
                      //       "${int.parse(waiterCharges.text) + int.parse(amount.text)}";
                      // },
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: AppColors.white,
                    //       borderRadius: BorderRadius.circular(10),
                    //       boxShadow: [
                    //         BoxShadow(color: AppColors.grey, blurRadius: 0.5)
                    //       ]),
                    //   child: RadioGroup<String>.builder(
                    //     groupValue: selectedCat,
                    //     direction: Axis.horizontal,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedCat = value!;
                    //       });
                    //       catering.text = '';
                    //       amount.text = '';
                    //     },
                    //     items: cat,
                    //     itemBuilder: (item) => RadioButtonBuilder(
                    //       item,
                    //     ),
                    //   ),
                    // ),
                    // AddVerticalSpace(11),
                    // TextView(
                    //     text: selectedCat == "Catering"
                    //         ? "Catering Payment"
                    //         : "Per Head Payment"),
                    // AddVerticalSpace(5),
                    // TextEditField(
                    //   hintText: selectedCat == "Catering"
                    //       ? "Catering Payment"
                    //       : "Per Head Payment",
                    //   prefixIcon: selectedCat == "Catering"
                    //       ? Icons.assistant_photo
                    //       : Icons.person_pin,
                    //   textEditingController: catering,
                    //   inputType: TextInputType.number,
                    //   hintcolor: cateringValid ? AppColors.red : AppColors.grey,
                    //   width: Dimensions.screenWidth(context),
                    //   onChanged: (value) {
                    //     if (selectedCat == "Catering") {
                    //       amount.text = "${int.parse(value)}";
                    //     } else {
                    //       amount.text =
                    //           "${int.parse(noOfCustomer.text) * int.parse(value)}";
                    //     }
                    //   },
                    // ),
                    AddVerticalSpace(11),
                    TextView(text: "Flower Decoration"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Flower Decoration",
                      prefixIcon: Icons.flare_outlined,
                      textEditingController: flowerDecoration,
                      inputType: TextInputType.number,
                      hintcolor: flowerDecorationValid
                          ? AppColors.red
                          : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                      // onEditingComplete: () {
                      //   if (waiterCharges.text != "") {
                      //     amount.text =
                      //         "${int.parse(amount.text) + int.parse(flowerDecoration.text)}";
                      //   } else {}
                      // },
                      onChanged: (value) {
                        if (value != "") {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(perHead.text)) +
                              int.parse(waiterCharges.text) +
                              int.parse(generator.text) +
                              int.parse(soundSystem.text) +
                              int.parse(taxPrice.text) +
                              int.parse(fanTotal.text) +
                              int.parse(foodBill.text) +
                              int.parse(acTotal.text) +
                              int.parse(value);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        } else {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(perHead.text)) +
                              int.parse(waiterCharges.text) +
                              int.parse(generator.text) +
                              int.parse(soundSystem.text) +
                              int.parse(taxPrice.text) +
                              int.parse(fanTotal.text) +
                              int.parse(foodBill.text) +
                              int.parse(acTotal.text);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        }
                      },
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Sound System"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Sound System",
                      prefixIcon: Icons.speaker,
                      inputType: TextInputType.number,
                      textEditingController: soundSystem,
                      hintcolor:
                          soundSystemValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                      // onEditingComplete: () {
                      //   amount.text =
                      //       "${int.parse(amount.text) + int.parse(soundSystem.text)}";
                      // },
                      onChanged: (value) {
                        if (value != "") {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(perHead.text)) +
                              int.parse(waiterCharges.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(generator.text) +
                              int.parse(foodBill.text) +
                              int.parse(fanTotal.text) +
                              int.parse(taxPrice.text) +
                              int.parse(acTotal.text) +
                              int.parse(value);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        } else {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(perHead.text)) +
                              int.parse(waiterCharges.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(generator.text) +
                              int.parse(fanTotal.text) +
                              int.parse(foodBill.text) +
                              int.parse(taxPrice.text) +
                              int.parse(acTotal.text);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        }
                      },
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Fan"),
                    AddVerticalSpace(5),
                    // TextEditField(
                    //   hintText: "Fan",
                    //   prefixIcon: Icons.flip_camera_android,
                    //   textEditingController: fan,
                    //   hintcolor: fanValid ? AppColors.red : AppColors.grey,
                    //   inputType: TextInputType.number,
                    //   width: Dimensions.screenWidth(context),
                    //   onFieldSubmitted: (value) {
                    //     if (catering.text != "") {
                    //       amount.text =
                    //           "${int.parse(amount.text) + int.parse(value)}";
                    //     } else {}
                    //   },
                    // ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextEditField(
                            hintText: "Quantity",
                            prefixIcon: Icons.flip_camera_android,
                            textEditingController: fanQuantity,
                            hintcolor:
                                fanValid ? AppColors.red : AppColors.grey,
                            inputType: TextInputType.number,
                            width: Dimensions.screenWidth(context) / 3.5,
                            // onFieldSubmitted: (value) {
                            //   if (catering.text != "") {
                            //     amount.text =
                            //         "${int.parse(amount.text) + int.parse(value)}";
                            //   } else {}
                            // },
                          ),
                          TextEditField(
                            hintText: "Price",
                            prefixIcon: Icons.flip_camera_android,
                            textEditingController: fanPrice,
                            hintcolor:
                                fanValid ? AppColors.red : AppColors.grey,
                            inputType: TextInputType.number,
                            width: Dimensions.screenWidth(context) / 3.5,
                            onChanged: (value) {
                              fanTotal.text =
                                  "${int.parse(fanQuantity.text) * int.parse(value)}";
                              if (value != "") {
                                int price = (int.parse(noOfCustomer.text) *
                                        int.parse(perHead.text)) +
                                    (int.parse(fanQuantity.text) *
                                        int.parse(value)) +
                                    int.parse(waiterCharges.text) +
                                    int.parse(flowerDecoration.text) +
                                    int.parse(taxPrice.text) +
                                    int.parse(acTotal.text) +
                                    int.parse(foodBill.text) +
                                    int.parse(generator.text) +
                                    int.parse(soundSystem.text);
                                amount.text = "${price}";
                                totalAmount.text =
                                    "${price - int.parse(discount.text)}";
                                Remaining.text =
                                    "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                              } else {
                                int price = (int.parse(noOfCustomer.text) *
                                        int.parse(perHead.text)) +
                                    int.parse(waiterCharges.text) +
                                    int.parse(flowerDecoration.text) +
                                    int.parse(acTotal.text) +
                                    int.parse(taxPrice.text) +
                                    int.parse(foodBill.text) +
                                    int.parse(generator.text) +
                                    int.parse(soundSystem.text);
                                amount.text = "${price}";
                                totalAmount.text =
                                    "${price - int.parse(discount.text)}";
                                Remaining.text =
                                    "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                              }
                            },
                          ),
                          TextEditField(
                            hintText: "Total",
                            prefixIcon: Icons.flip_camera_android,
                            readOnly: true,
                            textEditingController: fanTotal,
                            hintcolor:
                                fanValid ? AppColors.red : AppColors.grey,
                            inputType: TextInputType.number,
                            width: Dimensions.screenWidth(context) / 3.5,
                          ),
                        ],
                      ),
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "AC"),
                    AddVerticalSpace(5),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextEditField(
                            hintText: "Hours",
                            prefixIcon: Icons.ac_unit,
                            textEditingController: acHour,
                            hintcolor:
                                fanValid ? AppColors.red : AppColors.grey,
                            inputType: TextInputType.number,
                            width: Dimensions.screenWidth(context) / 3.5,
                            // onFieldSubmitted: (value) {
                            //   if (catering.text != "") {
                            //     amount.text =
                            //         "${int.parse(amount.text) + int.parse(value)}";
                            //   } else {}
                            // },
                          ),
                          TextEditField(
                            hintText: "Price",
                            prefixIcon: Icons.ac_unit,
                            textEditingController: acPrice,
                            hintcolor:
                                fanValid ? AppColors.red : AppColors.grey,
                            inputType: TextInputType.number,
                            width: Dimensions.screenWidth(context) / 3.5,
                            onChanged: (value) {
                              acTotal.text =
                                  "${int.parse(acHour.text) * int.parse(value)}";

                              if (value != "") {
                                int price = (int.parse(noOfCustomer.text) *
                                        int.parse(perHead.text)) +
                                    (int.parse(acHour.text) *
                                        int.parse(value)) +
                                    int.parse(waiterCharges.text) +
                                    int.parse(flowerDecoration.text) +
                                    int.parse(soundSystem.text) +
                                    int.parse(generator.text) +
                                    int.parse(taxPrice.text) +
                                    int.parse(foodBill.text) +
                                    int.parse(fanTotal.text);
                                amount.text = "${price}";
                                totalAmount.text =
                                    "${price - int.parse(discount.text)}";
                                Remaining.text =
                                    "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                              } else {
                                int price = (int.parse(noOfCustomer.text) *
                                        int.parse(perHead.text)) +
                                    int.parse(waiterCharges.text) +
                                    int.parse(flowerDecoration.text) +
                                    int.parse(soundSystem.text) +
                                    int.parse(foodBill.text) +
                                    int.parse(generator.text) +
                                    int.parse(taxPrice.text) +
                                    int.parse(fanTotal.text);
                                amount.text = "${price}";
                                totalAmount.text =
                                    "${price - int.parse(discount.text)}";
                                Remaining.text =
                                    "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                              }
                            },
                          ),
                          TextEditField(
                            hintText: "Total",
                            prefixIcon: Icons.ac_unit,
                            readOnly: true,
                            textEditingController: acTotal,
                            hintcolor:
                                fanValid ? AppColors.red : AppColors.grey,
                            inputType: TextInputType.number,
                            width: Dimensions.screenWidth(context) / 3.5,
                          ),
                        ],
                      ),
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Generator"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Generator",
                      prefixIcon: Icons.electric_bolt,
                      inputType: TextInputType.number,
                      textEditingController: generator,
                      hintcolor:
                          generatorValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                      // onEditingComplete: () {
                      //   amount.text =
                      //       "${int.parse(amount.text) + int.parse(generator.text)}";
                      // },
                      onChanged: (value) {
                        if (value != "") {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(perHead.text)) +
                              int.parse(waiterCharges.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(soundSystem.text) +
                              int.parse(fanTotal.text) +
                              int.parse(foodBill.text) +
                              int.parse(taxPrice.text) +
                              int.parse(acTotal.text) +
                              int.parse(value);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        } else {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(perHead.text)) +
                              int.parse(waiterCharges.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(soundSystem.text) +
                              int.parse(foodBill.text) +
                              int.parse(taxPrice.text) +
                              int.parse(fanTotal.text) +
                              int.parse(acTotal.text);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        }
                      },
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Tax"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Tax",
                      prefixIcon: Icons.money,
                      textEditingController: taxPrice,
                      inputType: TextInputType.number,
                      hintcolor: discountValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                      onChanged: (value) {
                        if (value != "") {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(perHead.text)) +
                              int.parse(waiterCharges.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(soundSystem.text) +
                              int.parse(fanTotal.text) +
                              int.parse(foodBill.text) +
                              int.parse(acTotal.text) +
                              int.parse(generator.text) +
                              int.parse(value);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        } else {
                          int price = (int.parse(noOfCustomer.text) *
                                  int.parse(perHead.text)) +
                              int.parse(waiterCharges.text) +
                              int.parse(flowerDecoration.text) +
                              int.parse(soundSystem.text) +
                              int.parse(foodBill.text) +
                              int.parse(fanTotal.text) +
                              int.parse(acTotal.text) +
                              int.parse(generator.text);
                          amount.text = "${price}";
                          totalAmount.text =
                              "${price - int.parse(discount.text)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        }
                      },
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Tax"),
                    AddVerticalSpace(5),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: AppColors.grey, blurRadius: 0.5)
                          ]),
                      child: DropdownButtonFormField2(
                        buttonPadding: EdgeInsets.only(
                          right: 10,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: AppColors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.payment,
                                color: AppColors.white,
                              ),
                            ),
                            AddHorizontalSpace(10),
                            TextView(
                              text: widget.entryModel.taxType,
                              fontSize: 14,
                              color: taxValid ? AppColors.red : AppColors.grey,
                            ),
                          ],
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.grey,
                        ),
                        iconSize: 30,
                        buttonHeight: 55,
                        // buttonPadding:
                        // const EdgeInsets.only(left: 20, right: 10),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        items: tax
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: AppColors.black,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.payment,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      AddHorizontalSpace(10),
                                      TextView(
                                        text: item,
                                        fontSize: 14,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select Days.';
                          }
                        },
                        onChanged: (value) {
                          if (noOfCustomer.text.isNotEmpty &&
                              perHead.text.isNotEmpty &&
                              waiterCharges.text.isNotEmpty) {
                            setState(() {
                              selectedTax = value!;
                            });

                            int price = (int.parse(noOfCustomer.text) *
                                    int.parse(perHead.text)) +
                                int.parse(waiterCharges.text) +
                                int.parse(flowerDecoration.text) +
                                int.parse(soundSystem.text) +
                                int.parse(fanTotal.text) +
                                int.parse(foodBill.text) +
                                int.parse(acTotal.text) +
                                int.parse(generator.text) +
                                int.parse(taxPrice.text);

                            // print(price);
                            // if (selectedTax == "FBR") {
                            //   double persent = (price * fbrTax) / 100;
                            //   Tax = persent;
                            // } else if (selectedTax == "PRA") {
                            //   double persent = (price * praTax) / 100;
                            //   Tax = persent;
                            // } else {
                            //   double persent =
                            //       (price * (fbrTax + praTax)) / 100;
                            //   Tax = persent;
                            // }
                            amount.text = "${price}";
                          } else {
                            FlutterErrorToast(
                                error: "Some Reqeired Fields\nare missing");
                          }

                          //Do something when changing the item if you want.
                        },
                      ),
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Amount"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Amount",
                      readOnly: true,
                      prefixIcon: Icons.money,
                      textEditingController: amount,
                      inputType: TextInputType.number,
                      hintcolor: amountValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Discount"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Discount",
                      prefixIcon: Icons.money,
                      textEditingController: discount,
                      inputType: TextInputType.number,
                      hintcolor: discountValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                      onChanged: (val) {
                        print(val);
                        if (val != "") {
                          totalAmount.text =
                              "${double.parse(amount.text) - int.parse(val)}";
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(Advance.text)}";
                        } else {
                          totalAmount.text = "${double.parse(amount.text)}";
                          Remaining.text =
                              "${double.parse(amount.text) - int.parse(Advance.text)}";
                        }
                      },
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Total Amount"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Total Amount",
                      readOnly: true,
                      prefixIcon: Icons.money,
                      textEditingController: totalAmount,
                      inputType: TextInputType.number,
                      hintcolor:
                          totalAmountValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Advance"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Advance",
                      prefixIcon: Icons.money,
                      textEditingController: Advance,
                      inputType: TextInputType.number,
                      hintcolor:
                          givenAmountValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                      onChanged: (val) {
                        if (val != "") {
                          Remaining.text =
                              "${double.parse(totalAmount.text) - int.parse(val)}";
                        } else {
                          Remaining.text = "${double.parse(totalAmount.text)}";
                        }
                      },
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Ramaining"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Ramaining",
                      readOnly: true,
                      prefixIcon: Icons.money,
                      textEditingController: Remaining,
                      inputType: TextInputType.number,
                      hintcolor:
                          returnAmountValid ? AppColors.red : AppColors.grey,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(11),
                    TextView(text: "Description"),
                    AddVerticalSpace(5),
                    TextEditField(
                      hintText: "Description",
                      prefixIcon: Icons.file_open,
                      textEditingController: description,
                      inputType: TextInputType.text,
                      hintcolor: AppColors.grey,
                      width: Dimensions.screenWidth(context),
                    ),
                    AddVerticalSpace(16),
                    TextView(text: "Images"),
                    AddVerticalSpace(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'jpeg', 'png'],
                            );

                            if (result != null) {
                              setState(() {
                                loading = true;
                              });
                              entryViewModel.images.value = result.paths
                                  .map((path) => File(path!))
                                  .toList();
                              for (int i = 0;
                                  i < entryViewModel.images.value.length;
                                  i++) {
                                final firebaseStorage = FirebaseStorage.instance
                                    .ref()
                                    .child('images_$time')
                                    .child(
                                        '${DateTime.now().millisecondsSinceEpoch}');
                                UploadTask uploadTask = firebaseStorage
                                    .putFile(entryViewModel.images.value[i]);
                                TaskSnapshot taskSnapshot = await uploadTask;

                                await taskSnapshot.ref
                                    .getDownloadURL()
                                    .then((value) async {
                                  if (value != null) {
                                    setState(() {
                                      entryViewModel.imagesURL.value.add(value);
                                      loading = false;
                                    });
                                    print(
                                        entryViewModel.imagesURL.value.length);
                                  }
                                });
                              }

                              print(entryViewModel.images.value);
                            } else {
                              // User canceled the picker
                              FlutterSimpleToast(msg: "Please Select images");
                            }
                          },
                          icon: Icon(
                            Icons.edit_note,
                          ),
                        ),
                      ],
                    ),
                    Obx(() => GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.9,
                            // mainAxisExtent: 150,
                          ),
                          itemCount: entryViewModel.imagesURL.value.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Image.network(
                                entryViewModel.imagesURL.value[index],
                              ),
                            );
                          },
                        )
                    ),
                    AddVerticalSpace(30),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: BTN(
                        title: "Update",
                        color: AppColors.black,
                        textColor: AppColors.white,
                        onPressed: () async {
                          setState(() {
                            if (selectedType.isEmpty) {
                              typeValid = true;
                            } else if (bookingDate.text.isEmpty) {
                              bookingDateValid = true;
                            } else if (eventName.text.isEmpty) {
                              eventNameValid = true;
                            } else if (partyName.text.isEmpty) {
                              partyNameValid = true;
                            } else if (partyNumber.text.isEmpty) {
                              partyNumberValid = true;
                            } else if (partyCNIC.text.isEmpty) {
                              partyCNICValid = true;
                            } else if (partyAddress.text.isEmpty) {
                              partyAddressValid = true;
                            } else if (noOfCustomer.text.isEmpty) {
                              noOfCustomerValid = true;
                            } else if (waiterCharges.text.isEmpty) {
                              waiterChargesPriceValid = true;
                            } else if (perHead.text.isEmpty) {
                              perHeadValid = true;
                            } else if (amount.text.isEmpty) {
                              amountValid = true;
                            } else if (selectedTax.isEmpty) {
                              taxValid = true;
                            } else if (totalAmount.text.isEmpty) {
                              totalAmountValid = true;
                            } else if (Advance.text.isEmpty) {
                              givenAmountValid = true;
                            } else if (Remaining.text.isEmpty) {
                              returnAmountValid = true;
                            }
                          });
                          if (selectedType.isNotEmpty &&
                              bookingDate.text.isNotEmpty &&
                              eventName.text.isNotEmpty &&
                              partyName.text.isNotEmpty &&
                              partyNumber.text.isNotEmpty &&
                              partyCNIC.text.isNotEmpty &&
                              partyAddress.text.isNotEmpty &&
                              noOfCustomer.text.isNotEmpty &&
                              waiterCharges.text.isNotEmpty &&
                              amount.text.isNotEmpty &&
                              totalAmount.text.isNotEmpty &&
                              Advance.text.isNotEmpty &&
                              perHead.text.isNotEmpty &&
                              Remaining.text.isNotEmpty) {
                            setState(() {
                              loading = true;
                            });
                            int time = DateTime.now().microsecondsSinceEpoch;

                            EntryModel entryModel = EntryModel(
                              entryID: widget.entryModel.entryID,
                              partyName: partyName.text,
                              enteredBy:
                                  FirebaseAuth.instance.currentUser!.email!,
                              noOfGuests: int.parse(noOfCustomer.text),
                              maleGuests: int.parse(maleCustomer.text),
                              femaleGuests: int.parse(femaleCustomer.text),
                              tax: int.parse(taxPrice.text),
                              // tax: int.parse(tax.text),
                              flowerDecoration:
                                  int.parse(flowerDecoration.text),
                              soundSystem: int.parse(soundSystem.text),
                              generator: int.parse(generator.text),
                              amount: double.parse(amount.text),
                              discount: double.parse(discount.text),
                              totalAmount: double.parse(totalAmount.text),
                              advance: double.parse(Advance.text),
                              remaining: double.parse(Remaining.text),
                              images: entryViewModel.imagesURL.value,
                              hallType: selectedType,
                              Lawn: selectedLawn,
                              time: selectedTime,
                              eventDate: dates[0]!.microsecondsSinceEpoch,
                              eventName: eventName.text,
                              lumsumGuests: int.parse(lumSumCustomer.text),
                              perHead: int.parse(perHead.text),
                              waiterChargesPrice: int.parse(waiterCharges.text),
                              perHeadPrice: (int.parse(perHead.text) *
                                  int.parse(noOfCustomer.text)),
                              fanQuantity: int.parse(fanQuantity.text),
                              fanPrice: int.parse(fanPrice.text),
                              acQuantity: int.parse(acHour.text),
                              acPrice: int.parse(acPrice.text),
                              taxType: selectedTax,
                              fanTotal: int.parse(fanTotal.text),
                              acTotal: int.parse(acTotal.text),
                              partyAddress: partyAddress.text,
                              partyNumber: partyNumber.text,
                              partyCNIC: partyCNIC.text,
                              description: description.text,
                              foodBill: int.parse(foodBill.text),
                            );

                            await FirebaseFirestore.instance
                                .collection("bookings")
                                .doc("${widget.entryModel.entryID}")
                                .update(entryModel.toJson())
                                .then((value) {
                              setState(() {
                                loading = false;
                              });
                              Get.back();
                            });
                          }
                        },
                        width: Dimensions.screenWidth(context),
                      ),
                    ),
                  ],
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
    );
  }
}

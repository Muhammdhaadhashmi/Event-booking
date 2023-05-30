import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:intl/intl.dart';
import 'package:merriage_management/ApplicationModules/EnteryModule/Models/entry_model.dart';
import 'package:merriage_management/ApplicationModules/HomeModule/Views/Components/image_list_item.dart';
import 'package:merriage_management/ApplicationModules/InvoiceModule/Views/Compnents/invoice_service.dart';
import 'package:merriage_management/Utils/dimensions.dart';
import 'package:merriage_management/Utils/spaces.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/selection_btn.dart';
import '../../../Utils/text_view.dart';

class InVoiceView extends StatefulWidget {
  final EntryModel entryModel;

  const InVoiceView({super.key, required this.entryModel});

  @override
  State<InVoiceView> createState() => _InVoiceViewState();
}

class _InVoiceViewState extends State<InVoiceView> {
  ScreenshotController screenshotController = ScreenshotController();

  File? screenShot;
  bool loading = false;

  Widget child = Text("wb");


  @override
  Widget build(BuildContext context) {
    double blur = loading ? 5 : 0;

    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaY: blur, sigmaX: blur),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.black,
              title: TextView(text: "Invoice"),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    screenshotController.capture().then((image) async {
                      setState(() async {
                        final doc = pw.Document();
                        doc.addPage(pw.Page(
                            pageFormat: PdfPageFormat.a4,
                            build: (pw.Context context) {
                              return pw.Center(
                                child: pw.Image(pw.MemoryImage(image!)),
                              ); // Center
                            }));

                        for (int i = 0;
                        i < widget.entryModel.images.length;
                        i++) {
                          Uint8List response = (await NetworkAssetBundle(
                              Uri.parse(widget.entryModel.images[i]))
                              .load(widget.entryModel.images[i]))
                              .buffer
                              .asUint8List();

                          doc.addPage(pw.Page(
                              pageFormat: PdfPageFormat.a4,
                              build: (pw.Context context) {
                                return pw.Center(
                                  child: pw.Image(pw.MemoryImage(response)),
                                ); // Center
                              }));
                        }

                        showModalBottomSheet<void>(
                          context: context,
                          backgroundColor: AppColors.transparent,
                          builder: (BuildContext context) {
                            return Container(
                              // height: 130,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SelectionBTN(
                                    width: Dimensions.screenWidth(context),
                                    title: "Save / Print",
                                    color: AppColors.white,
                                    margin: 5,
                                    onPressed: () async {
                                      await Printing.layoutPdf(
                                          onLayout:
                                              (PdfPageFormat format) async =>
                                              doc.save());
                                    },
                                  ),
                                  SelectionBTN(
                                    width: Dimensions.screenWidth(context),
                                    title: "Share",
                                    color: AppColors.white,
                                    margin: 5,
                                    onPressed: () async {
                                      await Printing.sharePdf(
                                          bytes: await doc.save(),
                                          filename:
                                          '${widget.entryModel.partyName} ${DateFormat.yMMMMd().format(DateTime.fromMicrosecondsSinceEpoch(widget.entryModel.eventDate))}.pdf');

                                    },
                                  ),
                                  AddVerticalSpace(5),
                                ],
                              ),
                            );
                          },
                        ).then((value) {
                          setState(() {
                            loading = false;
                          });
                        });
                      });
                    }).catchError((onError) {
                      print(onError);
                    });
                  },
                  icon: Icon(Icons.picture_as_pdf),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: Container(
                      // height: Dimensions.screenHeight(context),
                        width: Dimensions.screenWidth(context),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(int i = 0; i < 1; i++) ...[
                              AddVerticalSpace(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        height: 70,
                                        width: 70,
                                        "assets/Images/logo.jpg",
                                      ),
                                      AddVerticalSpace(5),
                                      TextView(
                                        text: "New Maqsood\nCountry Club",
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      TextView(
                                        text: "Rahim Yar khan",
                                        color: AppColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextView(
                                        text: "Invoice",
                                        color: AppColors.blue,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          TextView(
                                            text: "${widget.entryModel.entryID}",
                                            color: AppColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          TextView(
                                            text:
                                            "${DateFormat.yMMMMd().format(DateTime.now())}",
                                            color: AppColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          TextView(
                                            text: "${widget.entryModel.enteredBy}",
                                            color: AppColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              AddVerticalSpace(10),
                              Container(
                                // height: 100,
                                width: Dimensions.screenWidth(context),
                                color: Colors.blue.withOpacity(0.4),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          text: "Customer Details",
                                          color: AppColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        Container(
                                          width: 120,
                                          child: TextView(
                                            text: "${widget.entryModel.partyName}",
                                            color: AppColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextView(
                                          text: "${widget.entryModel.partyNumber}",
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        TextView(
                                          text: "${widget.entryModel.partyCNIC}",
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        TextView(
                                          text: "${widget.entryModel.partyAddress}",
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 140,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          TextView(
                                            text: "Event Details",
                                            color: AppColors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          TextView(
                                            text: "${widget.entryModel.eventName}",
                                            color: AppColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          TextView(
                                            text: widget.entryModel.hallType ==
                                                "Lawn"
                                                ? "${widget.entryModel.hallType} (${widget.entryModel.Lawn})"
                                                : "${widget.entryModel.hallType}",
                                            color: AppColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          TextView(
                                            text: "${widget.entryModel.time}",
                                            color: AppColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          TextView(
                                            text:
                                            "${DateFormat.yMMMMd().format(DateTime.fromMicrosecondsSinceEpoch(widget.entryModel.eventDate))}",
                                            color: AppColors.black,
                                            //you can use this to change plz solve tthis
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AddVerticalSpace(10),
                              TextView(
                                text: "Description",
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              AddVerticalSpace(5),
                              TextView(
                                text:
                                "${widget.entryModel.description}",
                                color: AppColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              AddVerticalSpace(10),
                              InvoiceService(
                                isHeader: true,
                                serial: "#",
                                service: "Services",
                                quantity: "Qty",
                                price: "Price",
                                unit: "Unit",
                                total: "Total",
                              ),
                              Divider(
                                color: AppColors.black,
                                height: 20,
                                thickness: 2,
                              ),
                              InvoiceService(
                                  serial: "1",
                                  service: "Guests (per head)",
                                  quantity: "${widget.entryModel.noOfGuests}",
                                  price: "${widget.entryModel.perHead}",
                                  unit: "Rs",
                                  total: "${widget.entryModel.perHeadPrice}"),
                              Divider(
                                color: AppColors.black,
                                height: 20,
                                thickness: 2,
                              ),
                              InvoiceService(
                                  serial: "2",
                                  service: "Waiter Charges",
                                  quantity: "N/A",
                                  price: "${widget.entryModel.waiterChargesPrice}",
                                  unit: "Rs",
                                  total: "${widget.entryModel.waiterChargesPrice}"
                                // "${widget.entryModel.noOfGuests *
                                // widget.entryModel.cateringPrice}",
                              ),
                              Divider(
                                color: AppColors.black,
                                height: 15,
                                thickness: 1,
                              ),
                              InvoiceService(
                                  serial: "2",
                                  service: "Food Bill",
                                  quantity: "N/A",
                                  price: "${widget.entryModel.foodBill}",
                                  unit: "Rs",
                                  total: "${widget.entryModel.foodBill}"
                                // "${widget.entryModel.noOfGuests *
                                // widget.entryModel.cateringPrice}",
                              ),
                              Divider(
                                color: AppColors.black,
                                height: 15,
                                thickness: 1,
                              ),
                              InvoiceService(
                                serial: "3",
                                service: "Fan",
                                quantity: "${widget.entryModel.fanQuantity}",
                                price: "${widget.entryModel.fanPrice}",
                                unit: "Rs",
                                total: "${widget.entryModel.fanTotal}",
                              ),
                              Divider(
                                color: AppColors.black,
                                height: 15,
                                thickness: 1,
                              ),
                              InvoiceService(
                                serial: "4",
                                service: "AC",
                                quantity: "${widget.entryModel.acQuantity}",
                                price: "${widget.entryModel.acPrice}",
                                unit: "Rs",
                                total: "${widget.entryModel.acTotal}",
                              ),
                              Divider(
                                color: AppColors.black,
                                height: 15,
                                thickness: 1,
                              ),
                              InvoiceService(
                                serial: "5",
                                service: "Decoration",
                                quantity: "N/A",
                                price: "${widget.entryModel.flowerDecoration}",
                                unit: "Rs",
                                total: "${widget.entryModel.flowerDecoration}",
                              ),
                              Divider(
                                color: AppColors.black,
                                height: 15,
                                thickness: 1,
                              ),
                              InvoiceService(
                                serial: "6",
                                service: "Sound System",
                                quantity: "N/A",
                                price: "${widget.entryModel.soundSystem}",
                                unit: "Rs",
                                total: "${widget.entryModel.soundSystem}",
                              ),
                              Divider(
                                color: AppColors.black,
                                height: 15,
                                thickness: 1,
                              ),
                              InvoiceService(
                                serial: "7",
                                service: "Generator",
                                quantity: "N/A",
                                price: "${widget.entryModel.generator}",
                                unit: "Rs",
                                total: "${widget.entryModel.generator}",
                              ),
                              AddVerticalSpace(10),
                              Divider(
                                color: AppColors.black,
                                height: 15,
                                thickness: 3,
                              ),
                              InvoiceService(
                                serial: "8",
                                service: "Sub Total",
                                quantity: "N/A",
                                price:
                                "${widget.entryModel.amount.ceil() - widget.entryModel.tax.ceil()}",
                                unit: "Rs",
                                total:
                                "${widget.entryModel.amount.ceil() - widget.entryModel.tax.ceil()}",
                              ),
                              Divider(
                                color: AppColors.black,
                                height: 15,
                                thickness: 1,
                              ),
                              InvoiceService(
                                serial: "9",
                                service: "Tax",
                                quantity: "N/A",
                                price: "${widget.entryModel.tax.ceil()}",
                                unit: "${widget.entryModel.taxType}",
                                total: "${widget.entryModel.amount.ceil()}",
                              ),
                              Divider(
                                color: AppColors.black,
                                height: 15,
                                thickness: 1,
                              ),
                              InvoiceService(
                                serial: "10",
                                service: "Discount",
                                quantity: "N/A",
                                price: "${widget.entryModel.discount.ceil()}",
                                unit: "Rs",
                                total:
                                "${widget.entryModel.amount.ceil() - widget.entryModel.discount.ceil()}",
                              ),
                              AddVerticalSpace(10),
                              Divider(
                                color: AppColors.black,
                                height: 15,
                                thickness: 3,
                              ),
                              AddVerticalSpace(10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextView(
                                  text:
                                  "Advance  :  ${widget.entryModel.advance.ceil()}",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              AddVerticalSpace(10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextView(
                                  text:
                                  "Remaining  :  ${widget.entryModel.remaining.ceil()}",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              AddVerticalSpace(20),
                              Container(
                                width: Dimensions.screenWidth(context),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 180,
                                      child: Divider(
                                        color: AppColors.black,
                                        height: 15,
                                        thickness: 4,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 160,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextView(
                                            text: "Total",
                                            color: AppColors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          TextView(
                                            text: ":",
                                            color: AppColors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          TextView(
                                            text:
                                            "${widget.entryModel.totalAmount.ceil()}",
                                            color: AppColors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ],
                        )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 400,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.entryModel.images.length,
                      itemBuilder: (context, index){
                        return FullScreenWidget(
                          backgroundIsTransparent: true,
                            child:Container(
                              margin: EdgeInsets.only(right: 15),
                              child: SizedBox(
                                width: 190.0,
                                height: 290.0,
                                child: PhotoView(
                                  imageProvider: NetworkImage(widget.entryModel.images[index]
                                  ),
                                ),
                              )
                              // child: ImageListItem(
                              //   image: widget.entryModel.images[index],
                              //   height: 400,
                              //   width: 220,
                              // ),
                            ),

                          );
                      },
                    ),
                  ),

                ],
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

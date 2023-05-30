import 'package:cloud_firestore/cloud_firestore.dart';

class EntryModel {
  EntryModel( {
    required this.entryID,
    required this.foodBill,
    required this.partyName,
    required this.noOfGuests,
    required this.maleGuests,
    required this.femaleGuests,
    required this.tax,
    required this.flowerDecoration,
    required this.soundSystem,
    required this.generator,
    required this.amount,
    required this.discount,
    required this.totalAmount,
    required this.advance,
    required this.remaining,
    required this.images,
    required this.lumsumGuests,
    required this.hallType,
    this.Lawn,
    required this.time,
    required this.eventDate,
    required this.eventName,
    required this.perHead,
    required this.waiterChargesPrice,
    required this.perHeadPrice,
    required this.taxType,
    required this.fanQuantity,
    required this.fanPrice,
    required this.acQuantity,
    required this.acPrice,
    required this.acTotal,
    required this.fanTotal,
    required this.partyNumber,
    required this.partyCNIC,
    required this.partyAddress,
    required this.description,
    required this.enteredBy,
  });

  final int entryID;

  final String partyName;
  final String enteredBy;
  final String description;
  final String partyNumber;
  final String partyCNIC;
  final String partyAddress;
  final int noOfGuests;
  final int perHeadPrice;
  final int maleGuests;
  final int femaleGuests;
  final int tax;
  final int foodBill;
  final int flowerDecoration;
  final int soundSystem;
  final int generator;
  final double amount;
  final double discount;
  final double totalAmount;
  final double advance;
  final double remaining;
  final List<dynamic> images;

  final int lumsumGuests;
  final String hallType;
  String? Lawn;
  final String time;
  final int eventDate;
  final String eventName;
  final int perHead;
  final int waiterChargesPrice;
  final String taxType;

  final int fanQuantity;
  final int fanPrice;
  final int acQuantity;
  final int acPrice;

  final int acTotal;
  final int fanTotal;

  factory EntryModel.fromJson(DocumentSnapshot doc) =>
      EntryModel(
        description: (doc.data() as dynamic)["description"] ?? "",
        foodBill: (doc.data() as dynamic)["foodBill"] ?? "",
        enteredBy: (doc.data() as dynamic)["enteredBy"] ?? "",
        partyName: (doc.data() as dynamic)["partyName"] ?? "",
        partyNumber: (doc.data() as dynamic)["partyNumber"] ?? "",
        entryID: (doc.data() as dynamic)["entryID"] ?? 0,
        partyCNIC: (doc.data() as dynamic)["partyCNIC"] ?? "",
        partyAddress: (doc.data() as dynamic)["partyAddress"] ?? "",
        noOfGuests: (doc.data() as dynamic)["noOfCustomer"] ?? 0,
        perHeadPrice: (doc.data() as dynamic)["perHeadPrice"] ?? 0,
        maleGuests: (doc.data() as dynamic)["maleCustomer"] ?? 0,
        femaleGuests: (doc.data() as dynamic)["femaleCustomer"] ?? 0,
        tax: (doc.data() as dynamic)["tax"] ?? 0,
        flowerDecoration: (doc.data() as dynamic)["flowerDecoration"] ?? 0,
        soundSystem: (doc.data() as dynamic)["soundSystem"] ?? 0,
        generator: (doc.data() as dynamic)["generator"] ?? 0,
        amount: (doc.data() as dynamic)["amount"] ?? 0.0,
        discount: (doc.data() as dynamic)["discount"] ?? 0.0,
        totalAmount: (doc.data() as dynamic)["totalAmount"] ?? 0.0,
        advance: (doc.data() as dynamic)["givenAmount"] ?? 0.0,
        remaining: (doc.data() as dynamic)["returnAmount"] ?? 0.0,
        images: (doc.data() as dynamic)["images"] ?? [],
        lumsumGuests: (doc.data() as dynamic)["lumsumGuests"] ?? 0,
        hallType: (doc.data() as dynamic)["hallType"] ?? "",
        Lawn: (doc.data() as dynamic)["Lawn"] ?? "",
        time: (doc.data() as dynamic)["time"] ?? "",
        eventDate: (doc.data() as dynamic)["eventDate"] ?? 0,
        eventName: (doc.data() as dynamic)["eventName"] ?? "",
        perHead: (doc.data() as dynamic)["perHead"] ?? "",
        waiterChargesPrice: (doc.data() as dynamic)["waiterChargesPrice"] ?? 0,
        taxType: (doc.data() as dynamic)["taxType"] ?? "",
        fanQuantity: (doc.data() as dynamic)["fanQuantity"] ?? 0,
        fanPrice: (doc.data() as dynamic)["fanPrice"] ?? 0,
        acQuantity: (doc.data() as dynamic)["acQuantity"] ?? 0,
        acPrice: (doc.data() as dynamic)["acPrice"] ?? 0,
        fanTotal: (doc.data() as dynamic)["fanTotal"] ?? 0,
        acTotal: (doc.data() as dynamic)["acTotal"] ?? 0,
      );

  Map<String, dynamic> toJson() =>
      {
        "entryID": entryID,
        "partyName": partyName,
        "foodBill": foodBill,
        "noOfCustomer": noOfGuests,
        "maleCustomer": maleGuests,
        "femaleCustomer": femaleGuests,
        "tax": tax,
        "soundSystem": soundSystem,
        "enteredBy": enteredBy,
        "generator": generator,
        "amount": amount,
        "discount": discount,
        "totalAmount": totalAmount,
        "givenAmount": advance,
        "returnAmount": remaining,
        "images": images,
        "lumsumGuests": lumsumGuests,
        "hallType": hallType,
        "Lawn": Lawn,
        "perHeadPrice": perHeadPrice,
        "time": time,
        "eventDate": eventDate,
        "eventName": eventName,
        "perHead": perHead,
        "waiterChargesPrice": waiterChargesPrice,
        "taxType": taxType,
        "fanQuantity": fanQuantity,
        "fanPrice": fanPrice,
        "acQuantity": acQuantity,
        "acPrice": acPrice,
        "acTotal": acTotal,
        "fanTotal": fanTotal,
        "partyNumber": partyNumber,
        "partyCNIC": partyCNIC,
        "partyAddress": partyAddress,
        "description": description,
        "flowerDecoration": flowerDecoration,
      };

  static List<EntryModel> jsonToListView(List<dynamic> data) {
    return data.map((e) => EntryModel.fromJson(e)).toList();
  }
}

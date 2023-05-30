import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';
import '../../EnteryModule/Models/entry_model.dart';
import '../../HomeModule/Views/Components/image_list_item.dart';
import 'history_view.dart';

class DeleteImages extends StatefulWidget {
  final EntryModel entryModel;
  const DeleteImages({Key? key, required this.entryModel}) : super(key: key);

  @override
  State<DeleteImages> createState() => _DeleteImagesState();
}

class _DeleteImagesState extends State<DeleteImages> {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> delete(ref, index, docId) async {
    var val = [];
    for (int i = 0; i < index; i++) {
      val.add('');
    }
    val.add('${widget.entryModel.images[index]}');
    print("+++++++++++++++++++++${val}");
    print("+++++++++++++++++++++${docId}");
    FirebaseFirestore.instance
        .collection("bookings")
        .doc("${docId}")
        .update({"images": FieldValue.arrayRemove(val)});

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Delete Images"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.entryModel.images.length,
                itemBuilder: (context, index) {
                  return FullScreenWidget(
                    backgroundIsTransparent: true,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 15),
                            child: SizedBox(
                              width: 190.0,
                              height: 290.0,
                              child: PhotoView(
                                imageProvider: NetworkImage(
                                    widget.entryModel.images[index]),
                              ),
                            )),
                        IconButton(
                          onPressed: () async {
                            print(
                                "=============================================${widget.entryModel.entryID}");
                            await delete(widget.entryModel.images[index], index,
                                widget.entryModel.entryID);
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HistoryView()));
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Image Deleted Successfully !")));
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

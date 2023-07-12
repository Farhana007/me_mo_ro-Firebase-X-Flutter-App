import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

import 'home_sc.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // creating firebase_storage instance to store image

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  // creating FirebaseDatabase instance  to store data in firebase

  final databaseRef = FirebaseDatabase.instance.ref('userdata');

  //TextEditing cotroller
  final _titlecontroller = TextEditingController();

  //image picker
  File? _img;

  final picker = ImagePicker();

  //function to pick image with image picker

  Future getImgGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    setState(() {
      if (pickedFile != null) {
        _img = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("please upload image"),
            backgroundColor: const Color.fromARGB(255, 54, 133, 244),
          ),
        );
      }
    });
  }

  //loading ver

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                          child: _img != null
                              ? Image.file(
                                  _img!.absolute,
                                  fit: BoxFit.contain,
                                )
                              : Center(
                                  child: Icon(
                                    Icons.image_outlined,
                                    size: 40,
                                    color: Colors.redAccent,
                                  ),
                                ))
                      .box
                      .height(200)
                      .width(200)
                      .rounded
                      .color(Colors.white)
                      .shadow
                      .make(),
                  50.heightBox,
                  IconButton(
                          onPressed: () {
                            getImgGallery();
                          },
                          icon: Icon(
                            Icons.upload_file_rounded,
                            size: 50,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ))
                      .box
                      .height(80)
                      .width(80)
                      .roundedFull
                      .shadow3xl
                      .color(Color.fromARGB(255, 102, 117, 194))
                      .make(),
                  5.heightBox,
                  "Upload Your File Here".text.black.make()
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: TextField(
                  controller: _titlecontroller,
                  decoration: InputDecoration(
                      hintText: "give your memory name",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                ),
              ),
              InkWell(
                onTap: () async {
                  //loding screen set stare

                  setState(() {
                    loading = true;
                  });
                  int id = DateTime.now().millisecondsSinceEpoch;

                  // to save image in firebase storage

                  firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref('/foldername' + id.toString());

                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(_img!.absolute);

                  Future.value(uploadTask).then((value) async {
                    var newUrl = await ref.getDownloadURL();

                    // to save title in database

                    databaseRef.child(id.toString()).set({
                      'id': id.toString(),
                      'fileN': newUrl.toString(),
                      'title': _titlecontroller.text.toString(),
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("added"),
                          backgroundColor: Color.fromARGB(255, 54, 238, 244),
                        ),
                      );
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                          backgroundColor: Colors.red,
                        ),
                      );
                    });
                    Get.to(() => HomeScreen());
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                    setState(() {
                      loading = false;
                    });
                  });
                },
                child: Container(
                  child: Center(
                      child: loading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : "Save"
                              .text
                              .color(Color.fromARGB(255, 255, 254, 255))
                              .size(25)
                              .make()),
                )
                    .box
                    .height(60)
                    .width(MediaQuery.of(context).size.width * 0.8)
                    .color(Color.fromARGB(255, 7, 79, 114))
                    .rounded
                    .shadow
                    .make(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

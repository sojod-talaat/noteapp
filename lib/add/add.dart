//import 'dart:html';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
//import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';

class Add extends StatefulWidget {
  Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  CollectionReference collectionre =
      FirebaseFirestore.instance.collection('Notes');
  late Reference ref;

  late File file;
  var title, note, imaur;
  GlobalKey<FormState> keyy = GlobalKey<FormState>();
  add() async {
    var formdate = keyy.currentState;
    if (formdate!.validate()) {
      formdate.save();
      await ref.putFile(file);
      imaur = await ref.getDownloadURL();
      await collectionre.add({
        'title': title,
        'note': note,
        'imageurl': imaur,
        'userid': FirebaseAuth.instance.currentUser!.uid
      });
      // Navigator.of(context).pushNamed('homepage');
    }
  }

  final imagpicker = ImagePicker();
  showbottom(context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            height: 170,
            child: Column(
              children: [
                Text('CHOSE IMAGE BT : '),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () async {
                    var pik = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pik != null) {
                      file = File(pik.path);
                      var ran = Random().nextInt(10000);
                      var imgname = '$ran' + basename(pik.path);

                      //***************************************************  image name can not solve it */
                      ref = FirebaseStorage.instance
                          .ref('images')
                          .child('$imgname');

                      /* await ref.putFile(file);
                      imaur = await ref.getDownloadURL();*/
                    }
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo_outlined,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'from Gallery',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
                InkWell(
                  onTap: () async {
                    var pick = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (pick != null) {
                      file = File(pick.path);
                      var ran = Random().nextInt(10000);
                      var imgname = '$ran' + basename(pick.path);
                      //***************************************************  image name can not solve it */
                      ref = FirebaseStorage.instance
                          .ref('images')
                          .child('$imgname');

                      /*await ref.putFile(file);
                      imaur = await ref.getDownloadURL();*/
                    }
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text('from camera'),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
  /* upload() async {
    // ignore: deprecated_member_use
    var pick = await imagpicker.pickImage(source: ImageSource.camera);

    if (pick != null) {
      setState(() {
        file = File(pick.path);
      });
    } else {}
  }*/

  @override
  Widget build(BuildContext context) {
    return /*Directionality(
      textDirection: TextDirection.rtl,
      child:  هاد الاشي عشااان اخلي الكتابة في التطبيق عكس*/
        Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[100],
        title: Text('Add Note'),
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(30),
                child: TextFormField(
                  validator: (val) {
                    if (val!.length >= 4) {
                      val = title;
                    }
                  },
                  onSaved: (val) {
                    val = title;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.orangeAccent,
                        )),
                    filled: true,

                    //fillColor: Colors.red,
                    labelText: 'type note title',
                    prefixIcon: Icon(Icons.note),
                  ),
                  maxLength: 30,
                  maxLines: 3,
                ),
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: TextFormField(
                  validator: (val) {
                    if (val!.length >= 4) {
                      note = val;
                    }
                  },
                  onSaved: (val) {
                    val = note;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.orangeAccent,
                        )),
                    filled: true,
                    //fillColor: Colors.red,
                    labelText: 'type note ',
                    prefixIcon: Icon(Icons.wrap_text_outlined),
                  ),
                  maxLines: 3,
                  maxLength: 200,
                ),
              ),
              SizedBox(
                height: 7.0,
              ),
              ElevatedButton(
                onPressed: () {
                  showbottom(context);
                  //upload();
                },
                child: Text('     Add new images      '),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                onPressed: () {
                  add();
                },
                child: Text('  Add note to data base  '),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ),
      //),
    );
  }
}

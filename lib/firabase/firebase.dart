//بدي هنا اعمل انه لما يعمل اي تغيير في الداتا بيس يتغير ويتعدل بدون ما ارجع اعمل رريفريش للصفحة وهذا من خلالل
//السنابشاتفايرستور

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sojod extends StatefulWidget {
  sojod({Key? key}) : super(key: key);

  @override
  _sojodState createState() => _sojodState();
}

DocumentReference docum =
    FirebaseFirestore.instance.collection('usres').doc('');

class _sojodState extends State<sojod> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('     get data     '),
        onPressed: () {
          add();
          update();
          delate();
          var user = FirebaseFirestore.instance
              .collection(
                  'usres') //هنا عشان لما اعدل على الداتا يتعدل على التطبيق عطول بدون ما اعمل هوت ريلود
              .snapshots()
              .listen((event) {
            event.docs.forEach((element) {
              print('username: ${element.data()["name"]}');
              print('username: ${element.data()["age"]}');
              print('*************************');
            });
          });
        },
      ),
    );
  }
}

//
add() async {
  var user = FirebaseFirestore.instance.collection('usres');
  //هادي لو بدي اضيفه ويكون الرقم عشوائي
  //user.add({'name': 'sojod', 'age': 12},);
  //لو بدي اعطيه انا رقم بعمل هيك
  user.doc('123456789').set({
    'name': 'saja',
    'age': 18,
  });
}

update() async {
  var user = FirebaseFirestore.instance.collection('usres');
  user.doc('123456789').update({
    'name': 'sojod',
  });
}

delate() async {
  var user = FirebaseFirestore.instance.collection('usres');
  user.where('age', isLessThan: 40).get().then((value) {
    value.docs.forEach((element) {
      element.data().clear();
    });
  });
}
//لو بدي أعدل في دوكيومنت موجود جوا كولكيشن بنعمل هيك

updata() async {
  var address = FirebaseFirestore.instance
      .collection('note')
      .doc('4S5CbID7kVu4zHsGY1ok')
      .collection('address');
  //الاضافة وحركاتهم كلهم هنا بضيفهم
  address.add({});
}

//الترانزاكشن هو انه لما بدي اعدل على اي معلومة لازم يضمن انه تعدل في كل الاماكن
//زي اسم المستخدم في كل البوستات لازم يتعدل وبنستخدم الاترانزكشن
updat() async {
  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot docs = await transaction.get(docum);

    if (docs.exists) {
      transaction.update(docum, {'name': 'soko'});
    } else {
      print('not exites');
    }
  });
}

//batch write
//عشان اقدر انفذ اكثر من عملية على البيانات والعمليات يا كلها تنجح يا كلها تفشل
bitch() async {
  WriteBatch batch = FirebaseFirestore.instance.batch();
  batch.delete(docum);
  batch.update(docum, {'name': 'sssss'});
}
//عشان اعرض البيانا ت في ال يو اي للتطبيق وهي الفيوتشربيلدر

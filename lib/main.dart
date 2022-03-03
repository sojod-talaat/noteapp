//import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/add/add.dart';
import 'package:noteapp/auit/login.dart';
import 'package:noteapp/auit/singup.dart';
import 'package:noteapp/home/homepage.dart';
//import 'package:sojod2/http.dart';

import 'firabase/firebase.dart';

bool islog = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //بعرف من هنا الشخص مسجل ولا لء
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    islog = false;
  } else {
    islog = true;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'OtomanopeeOne',
        textTheme: TextTheme(),
      ),
      routes: {
        'login': (context) => Login(),
        'singup': (context) => SingUp(),
        'homepage': (context) => Homepage(),
        'Add': (context) => Add(),
      },
      home: //sojod(),
          islog == false ? Login() : Homepage(),
    );
  }
}

get() async {
  var pin =
      await FirebaseFirestore.instance.collection('usres').get().then((value) {
    value.docs.forEach((element) {
      print(element.data());
    });
  });
}

getdoc() async {
  var pin = FirebaseFirestore.instance
      .collection("usrse")
      .doc("7ThYRUBcaMz5TIwBsLoe")
      .get()
      .then((value) {
    print(value.data());
  });
}

getdata() async {
  var userage = FirebaseFirestore.instance.collection('usrse');
  userage.where('age', isEqualTo: 20).get().then((value) {
    value.docs.forEach((element) {
      print(element.data());
    });
  });
}
//لو بدي أفحص ع اكثر من قيمة مثلا بدي الطلاب اللي عمرهم 20 و30

getdata2() async {
  var userage = FirebaseFirestore.instance.collection('usrse');
  userage.where('age', whereIn: [20]).get().then((value) {
        value.docs.forEach((element) {
          print(element.data());
        });
      });
}

//لو بدي ابحث في مصفوفة
getdata3() async {
  var user = FirebaseFirestore.instance.collection('usres');
  //لما تكون هيك في مصفوفة بتكون عبارة عن اما او انه مثلا بيحكي عربي او انجليزي
  user.where('lang', arrayContains: 'ar').get().then((value) {
    value.docs.forEach((element) {
      print(element.data()['username']);
    });
  });
}

//
getdata4() async {
  var user = FirebaseFirestore.instance.collection('usres');
  await user.orderBy('age').get().then((value) {
    value.docs.forEach((element) {
      print(element.data()['username']);
    });
  });
}

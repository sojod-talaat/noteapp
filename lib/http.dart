import 'package:flutter/material.dart';
//import 'package:sojod2/http.dart' as sojod;
import 'dart:convert';

class sojod5 extends StatefulWidget {
  sojod5({Key? key}) : super(key: key);

  @override
  _sojod5State createState() => _sojod5State();
}

class _sojod5State extends State<sojod5> {
  get http => null;

  Future post() async {
    //نوع الريكوست
    var url = 'https://jsonplaceholder.typicode.com/albums';
    var requsatt = await http.get(url);
    //بدي افك الترميييز
    var respon = jsonDecode(requsatt.body);
    print(requsatt.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    post();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:noteapp/alert/aleart.dart';
//import 'package:awesome_dialog/awesome_dialog.dart';

class SingUp extends StatefulWidget {
  SingUp({Key? key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  Color maincolor = Color(0xFFffffff);
  String email = '';
  String password = '';
  String username = '';

  GlobalKey<FormState> s4 = new GlobalKey<FormState>();
  SinguP() async {
    var formdata = s4.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        show(context);
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50)),
              ),
              width: double.infinity,
              child: Image.asset(
                'images/sojod2.jpg',
                height: 300,
                width: 300,
              ),
            ),

            Form(
              key: s4,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60.0),
                  topLeft: Radius.circular(60.0),
                )),
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        username = val!;
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(15)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                            size: 15,
                          ),
                          labelText: 'UserName',
                          hintStyle: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.length < 3) {
                          return 'no';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        email = val!;
                      },
                      // obscureText: true,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(20)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blue,
                            size: 15,
                          ),
                          labelText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        password = val!;
                      },
                      validator: (text) {
                        if (text!.length < 3) {
                          return 'no';
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(15)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.blue,
                            size: 15,
                          ),
                          labelText: 'password',
                          hintStyle: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    /*
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(15)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.blue,
                            size: 15,
                          ),
                          labelText: 'phone',
                          hintStyle: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          )),
                    ),*/
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          Text('if you have account'),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('login');
                              },
                              child: Text(
                                'click here',
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                        child: Text(' create account '),
                        onPressed: () async {
                          UserCredential respons = await SinguP();
                          print(respons.user!.email);
                          // ignore: unnecessary_null_comparison
                          if (respons != null) {
                            Navigator.of(context).pushNamed('homepage');
                            await FirebaseFirestore.instance
                                .collection('usres')
                                .add({
                              'userename': username,
                              'email': email,
                            });
                          }

                          /* AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                            width: 280,
                            buttonsBorderRadius:
                                BorderRadius.all(Radius.circular(2)),
                            headerAnimationLoop: false,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'INFO',
                            desc: ' Singup done   ...',
                            showCloseIcon: true,
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          )..show();*/
                        })
                  ],
                ),
              ),
            ),
            //ElevatedButton(
            // child: Text('Login'),
            //onPressed: () {},
            // )
          ],
        ),
      ),
    );
  }
}

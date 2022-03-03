import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noteapp/alert/aleart.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late UserCredential userCredential;
  Color sec4 = Color(0xFFBCBEDC);
  String username = '';
  String password = '';
  String email = '';
  GlobalKey<FormState> key = new GlobalKey<FormState>();
  singin() async {
    var formdata = key.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        show(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
        } else {
          print('not valied');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: sec4,
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Image.asset(
                'images/3.png',
                width: 400,
                height: 400,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Form(
              key: key,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        if (val!.length > 100) {
                          return 'email to long';
                        }
                        if (val.length < 2) {
                          return 'email too short ';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        email = val!;
                      },
                      //obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.orangeAccent,
                        ),
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.length < 2) {
                          return 'to short';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        password = val!;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.orangeAccent,
                        ),
                        labelText: 'password',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          Text('if you do not hava account',
                              style: TextStyle(fontSize: 15)),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('singup');
                            },
                            child: Text(
                              'click here',
                              style: TextStyle(
                                  color: Colors.orangeAccent, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        primary: Colors.orangeAccent,
                      ),
                      child: Text(
                        '       Log In       ',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () async {
                        var user = await singin();
                        if (user != null) {
                          Navigator.of(context).pushNamed('homepage');
                        }

                        /* userCredential =
                            await FirebaseAuth.instance.signInAnonymously();
                        Navigator.of(context).pushNamed('homepage');*/
                        /*try {
                          userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: "barry.allen@example.com",
                                  password: "SuperSecretPassword!");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                        ;*/
                      },
                    )
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

import 'package:citycafe_app/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_screen.dart';
import 'package:ionicons/ionicons.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController user_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  String us_id = "";
  bool googleenter = false;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 20, bottom: 20),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  Widget _submitButton(text, icon, fun) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              width: 50,
            ),
            Text(
              '${text}',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login_screen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("images/1.png"))),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Lt',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffe46b10)),
              children: [
                TextSpan(
                  text: 'uc Stu',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                TextSpan(
                  text: 'dents',
                  style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
                ),
              ]),
        ),
      ],
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username"),
        TextField(
            controller: user_name,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true)),
        _entryField("Email id"),
        TextField(
            controller: email,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true)),
        _entryField("Password"),
        TextField(
            controller: pass,
            obscureText: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Text("abed"),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .1),
                    _title(),
                    SizedBox(
                      height: 30,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 15,
                    ),
                    _submitButton("Continue with Google", Ionicons.logo_google,
                        () async {
                      try {
                        final GoogleSignInAccount? googleUser =
                            await GoogleSignIn().signIn();
                        final GoogleSignInAuthentication? googleAuth =
                            await googleUser?.authentication;
                        final credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth?.accessToken,
                          idToken: googleAuth?.idToken,
                        );
                        var auth = FirebaseAuth.instance;
                        UserCredential myuser =
                            await auth.signInWithCredential(credential);
                        us_id = myuser.user!.uid;
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(myuser.user!.uid)
                            .set({
                          'Username': myuser.user!.displayName,
                          "Email": myuser.user!.email,
                          'password': "",
                          'user_type': "user",
                          'user_id': us_id
                        });
                        googleenter = true;
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Home(
                              us_id: us_id,
                              googleenter: googleenter,
                            );
                          },
                        ));
                        print("sign up done");
                      } on Exception catch (e) {
                        print(e.toString());
                      }
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    _submitButton(
                      "       Register Now",
                      Ionicons.enter,
                      () async {
                        try {
                          var auth = FirebaseAuth.instance;
                          UserCredential myuser =
                              await auth.createUserWithEmailAndPassword(
                                  email: email.text, password: pass.text);
                          us_id = myuser.user!.uid;

                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(myuser.user!.uid)
                              .set({
                            'Username': user_name.text,
                            "Email": email.text,
                            'password': pass.text,
                            'user_type': "user",
                            'user_id': us_id
                          });
                          googleenter = false;
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Home(
                                us_id: us_id,
                                googleenter: googleenter,
                              );
                            },
                          ));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${e.toString()}")));
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}

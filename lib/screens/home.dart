import 'package:citycafe_app/Components/add.dart';
import 'package:citycafe_app/Components/delete.dart';
import 'package:citycafe_app/Components/read.dart';
import 'package:citycafe_app/Components/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  Home({this.us_id, this.googleenter});
  String? us_id;
  bool? googleenter;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var type;
  var email;
  var un;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.us_id)
        .snapshots()
        .listen((event) {
      setState(() {
        email = event['Email'];
        un = event['Username'];
        type = event['user_type'];
      });
    });
    if (type == "admin") {
      return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xffe46b10),
              bottom: TabBar(
                indicatorColor: Colors.red,
                tabs: [
                  Tab(
                    child: Icon(Ionicons.reader),
                  ),
                  Tab(
                    child: Icon(Ionicons.add),
                  ),
                  Tab(
                    child: Icon(Ionicons.trash_bin),
                  ),
                  Tab(
                    child: Icon(Icons.update),
                  ),
                ],
              ),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                          "https://as1.ftcdn.net/v2/jpg/00/07/32/48/1000_F_7324864_FXazuBCI3dQBwIWY7gaWQzXskXJaTbrY.jpg")),
                  SizedBox(
                    height: 50,
                  ),
                  Text("Email :",
                      style: GoogleFonts.fuzzyBubbles(
                          fontSize: 20, color: Color(0xffe46b10))),
                  Text(email, style: GoogleFonts.fuzzyBubbles(fontSize: 20)),
                  SizedBox(
                    height: 15,
                  ),
                  Text("UserName :",
                      style: GoogleFonts.fuzzyBubbles(
                          fontSize: 20, color: Color(0xffe46b10))),
                  Text(un, style: GoogleFonts.fuzzyBubbles(fontSize: 20)),
                  SizedBox(
                    height: 15,
                  ),
                  Text("User Type:",
                      style: GoogleFonts.fuzzyBubbles(
                          fontSize: 20, color: Color(0xffe46b10))),
                  Text(type, style: GoogleFonts.fuzzyBubbles(fontSize: 20)),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.us_id)
                          .update({'user_type': "user"});
                      setState(() {
                        type = "user";
                      });
                    },
                    icon: Icon(
                      Icons.switch_account,
                      size: 30,
                    ),
                    label: Text(
                      "Switch to user",
                      style: GoogleFonts.fuzzyBubbles(fontSize: 25),
                    ),
                    style: ElevatedButton.styleFrom(primary: Color(0xffe46b10)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (widget.googleenter!) {
                        final GoogleSignInAccount? googleUser =
                            await GoogleSignIn().signOut();
                      } else
                        await FirebaseAuth.instance.signOut();
                      print("User Sign Out");
                      Navigator.pushNamed(context, "login");
                    },
                    icon: Icon(
                      Ionicons.log_out,
                      size: 30,
                    ),
                    label: Text("LogOut",
                        style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
                    style: ElevatedButton.styleFrom(primary: Color(0xffe46b10)),
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              Read(),
              Add(),
              Delete(),
              Update(),
            ]),
          ));
    } else {
      return DefaultTabController(
          length: 1,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                indicatorColor: Colors.red,
                tabs: [
                  Tab(
                    child: Icon(Ionicons.reader),
                  ),
                ],
              ),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                          "https://thumbs.dreamstime.com/b/user-word-cloud-user-word-cloud-business-concept-206259964.jpg")),
                  SizedBox(
                    height: 50,
                  ),
                  Text("Email :",
                      style: GoogleFonts.fuzzyBubbles(
                          fontSize: 20, color: Colors.blue.shade500)),
                  Text(email, style: GoogleFonts.fuzzyBubbles(fontSize: 20)),
                  SizedBox(
                    height: 15,
                  ),
                  Text("UserName :",
                      style: GoogleFonts.fuzzyBubbles(
                          fontSize: 20, color: Colors.blue.shade500)),
                  Text(un, style: GoogleFonts.fuzzyBubbles(fontSize: 20)),
                  SizedBox(
                    height: 15,
                  ),
                  Text("User Type:",
                      style: GoogleFonts.fuzzyBubbles(
                          fontSize: 20, color: Colors.blue.shade500)),
                  Text(type, style: GoogleFonts.fuzzyBubbles(fontSize: 20)),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.us_id)
                            .update({'user_type': "admin"});
                        setState(() {
                          type = "admin";
                        });
                      },
                      icon: Icon(
                        Icons.switch_account,
                        size: 30,
                      ),
                      label: Text("Switch to Admin",
                          style: GoogleFonts.fuzzyBubbles(fontSize: 25))),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        if (widget.googleenter!) {
                          final GoogleSignInAccount? googleUser =
                              await GoogleSignIn().signOut();
                        } else
                          await FirebaseAuth.instance.signOut();
                        print("User Sign Out");
                        Navigator.pushNamed(context, "login");
                      },
                      icon: Icon(
                        Ionicons.log_out,
                        size: 30,
                      ),
                      label: Text("LogOut",
                          style: GoogleFonts.fuzzyBubbles(fontSize: 30))),
                ],
              ),
            ),
            body: TabBarView(children: [
              Read(),
            ]),
          ));
    }
  }
}

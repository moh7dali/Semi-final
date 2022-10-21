import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController course = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 25,
          ),
          Text("Enter Student ID :",
              style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
          SizedBox(
            height: 25,
          ),
          TextField(
            controller: id,
            decoration: InputDecoration(
                hintText: 'Enter Student Id',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600))),
          ),
          SizedBox(
            height: 25,
          ),
          Text("Enter Student Name :",
              style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
          SizedBox(
            height: 25,
          ),
          TextField(
            controller: name,
            decoration: InputDecoration(
                hintText: 'Enter Student Name',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600))),
          ),
          SizedBox(
            height: 25,
          ),
          Text("Enter Course :", style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
          SizedBox(
            height: 25,
          ),
          TextField(
            controller: course,
            decoration: InputDecoration(
                hintText: 'Enter Course Name',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600))),
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton.icon(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('Ltuc_student')
                  .doc("Doc" + id.text)
                  .set({
                'Student_id': id.text,
                'Student_name': name.text,
                'course': course.text
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Added")));
            },
            icon: Icon(
              Ionicons.add,
              size: 30,
            ),
            label: Text("Add To Data",
                style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
            style: ElevatedButton.styleFrom(primary: Color(0xffe46b10)),
          )
        ]),
      ),
    );
  }
}

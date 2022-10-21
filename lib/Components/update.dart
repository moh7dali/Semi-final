import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController course = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [
            Text("Enter Student ID You Want To Update:",
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
            Text(
                "You Cannot Change Student ID Just change Name or Course name ",
                style:
                    GoogleFonts.fuzzyBubbles(fontSize: 15, color: Colors.red)),
            SizedBox(
              height: 25,
            ),
            Text("Student Name:",
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
            Text("Enter Course :",
                style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
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
                    .update({'Student_name': name.text, 'course': course.text});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Updated")));
              },
              icon: Icon(
                Icons.update,
                size: 30,
              ),
              label:
                  Text("Update", style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
              style: ElevatedButton.styleFrom(primary: Color(0xffe46b10)),
            ),
          ]),
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Delete extends StatefulWidget {
  const Delete({super.key});

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  TextEditingController id = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          SizedBox(
            height: 25,
          ),
          Text("Enter Student ID You Want To Delete:",
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
          ElevatedButton.icon(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('Ltuc_student')
                  .doc("Doc" + id.text)
                  .delete();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Deleted")));
            },
            icon: Icon(
              Icons.update,
              size: 30,
            ),
            label:
                Text("Delete", style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
            style: ElevatedButton.styleFrom(primary: Color(0xffe46b10)),
          ),
        ]));
  }
}

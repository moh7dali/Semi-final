import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Read extends StatefulWidget {
  const Read({super.key});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Ltuc_student')
            .orderBy('Student_id')
            .snapshots(),
        builder: (context, snapshot) {
          final docs = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) => Column(children: [
                Text(
                    "Student ID: " +
                        docs[index]['Student_id'].toString() +
                        "\n" +
                        "Student Name: " +
                        docs[index]['Student_name'] +
                        "\n"
                            "Course Name: " +
                        docs[index]['course'].toString(),
                    style: GoogleFonts.fuzzyBubbles(fontSize: 30)),
                Divider(
                  color: Color(0xffe46b10),
                  height: 30,
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}

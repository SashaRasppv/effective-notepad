import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/manipulation_with_notes/notes_functional.dart';
import '../style/app_styles.dart';

// functions

void deleteFunction(
    BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, int index) {
  Provider.of<NotesFunctional>(context, listen: false)
      .deleteNote(snapshot, index);
  Navigator.pop(context);
}

// functions

// ---------------

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(
      {Key? key,
      required this.doc,
      required this.snapshot,
      required this.index})
      : super(key: key);
  QueryDocumentSnapshot doc;
  AsyncSnapshot<QuerySnapshot> snapshot;
  int index;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 254, 215, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(208, 247, 217, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),

          // Note details

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.doc['note_title'],
                style: GoogleFonts.righteous(
                    fontSize: 28, color: const Color.fromRGBO(37, 29, 58, 1)),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  widget.doc['creation_date'],
                  style: GoogleFonts.readexPro(
                      fontSize: 14, color: const Color.fromRGBO(37, 29, 58, 1)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.doc['note_content'],
                style: GoogleFonts.readexPro(
                    fontSize: 20, color: const Color.fromRGBO(37, 29, 58, 1)),
              )
            ],
          ),

          // Note details
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(255, 178, 178, 1),
        onPressed: () => deleteFunction(context, widget.snapshot, widget.index),
        child: Text(
          'DELETE',
          style: GoogleFonts.righteous(
              fontSize: 12, color: const Color.fromRGBO(255, 254, 215, 1)),
        ),
      ),
    );
  }
}

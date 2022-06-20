import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/provider/manipulation_with_notes/notes_functional.dart';
import 'package:notes/style/app_styles.dart';
import 'package:provider/provider.dart';

// functions

void createNote(BuildContext context, TextEditingController titleController,
    String date, TextEditingController contentController) {
  Provider.of<NotesFunctional>(context, listen: false)
      .createNote(titleController.text, date, contentController.text);
  Navigator.pop(context);
}

// functions

// ---------------

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  String date = DateTime.now().toString();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(168, 153, 214, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(168, 153, 214, 1),
        title: Text('ADD NEW NOTE',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: NoteEditingTools(
              titleController: _titleController,
              date: date,
              contentController: _contentController),
        ),
      ),
      floatingActionButton: SaveButton(
          titleController: _titleController,
          date: date,
          contentController: _contentController),
    );
  }
}

// ---------------

// Note edit tools

class NoteEditingTools extends StatelessWidget {
  const NoteEditingTools({
    Key? key,
    required TextEditingController titleController,
    required this.date,
    required TextEditingController contentController,
  })  : _titleController = titleController,
        _contentController = contentController,
        super(key: key);

  final TextEditingController _titleController;
  final String date;
  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          maxLines: null,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Note Title',
              hintStyle: GoogleFonts.righteous(
                  fontSize: 28, color: const Color.fromRGBO(37, 29, 58, 1))),
          style: GoogleFonts.righteous(
              fontSize: 28, color: const Color.fromRGBO(37, 29, 58, 1)),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Text(
            date,
            style: AppStyles.date,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        TextField(
          controller: _contentController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Note Content',
              hintStyle: GoogleFonts.readexPro(
                  fontSize: 20, color: const Color.fromRGBO(37, 29, 58, 1))),
          maxLines: null,
          style: GoogleFonts.readexPro(
              fontSize: 20, color: const Color.fromRGBO(37, 29, 58, 1)),
        ),
      ],
    );
  }
}

// Note edit tools

// ---------------

// Save button

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required TextEditingController titleController,
    required this.date,
    required TextEditingController contentController,
  })  : _titleController = titleController,
        _contentController = contentController,
        super(key: key);

  final TextEditingController _titleController;
  final String date;
  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: const Color.fromRGBO(208, 247, 217, 1),
        onPressed: () =>
            createNote(context, _titleController, date, _contentController),
        child: Text(
          'SAVE',
          style: GoogleFonts.righteous(
              fontSize: 12, color: const Color.fromRGBO(168, 153, 214, 1)),
        ));
  }
}

// Save button
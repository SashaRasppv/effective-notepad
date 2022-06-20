import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/provider/manipulation_with_notes/notes_functional.dart';
import 'package:notes/ui/note_editor.dart';
import 'package:notes/ui/note_reader.dart';
import 'package:provider/provider.dart';
import '../style/app_styles.dart';

// functions

void deleteFunction(
    BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, int index) {
  Provider.of<NotesFunctional>(context, listen: false)
      .deleteNote(snapshot, index);
}

// functions

// ---------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(208, 247, 217, 1),
        title: Text(
          'Your Recent Notes',
          style: GoogleFonts.readexPro(
              color: const Color.fromRGBO(168, 153, 214, 1),
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
      ),
      backgroundColor: const Color.fromRGBO(168, 153, 214, 1),
      body: Column(
        children: const [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          Notes()
        ],
      ),
      floatingActionButton: const AddButton(),
    );
  }
}

// ---------------

// Add button

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoteEditorScreen()));
      },
      label: Text(
        'ADD NOTE',
        style: GoogleFonts.righteous(
            color: const Color.fromRGBO(168, 153, 214, 1), fontSize: 12),
      ),
      backgroundColor: const Color.fromRGBO(208, 247, 217, 1),
    );
  }
}

// Add button

// ---------------

// Notes

class Notes extends StatelessWidget {
  const Notes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Notes').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No notes yet'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteReaderScreen(
                                  doc: snapshot.data!.docs[index],
                                  snapshot: snapshot,
                                  index: index)));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 254, 215, 1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.docs[index]['note_title'],
                              style: AppStyles.titleStyle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                snapshot.data!.docs[index]['creation_date'],
                                style: AppStyles.date,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data!.docs[index]['note_content'],
                              style: AppStyles.contentStyle,
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    primary:
                                        const Color.fromRGBO(255, 178, 178, 1),
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Color.fromRGBO(255, 254, 215, 1),
                                  ),
                                  onPressed: () =>
                                      deleteFunction(context, snapshot, index),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
                child: Text(
              'There is no Notes',
              style: GoogleFonts.nunito(color: Colors.white),
            ));
          }),
    );
  }
}

// Notes
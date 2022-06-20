import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotesFunctional extends ChangeNotifier {
  // Delete note

  void deleteNote(AsyncSnapshot<QuerySnapshot> snapshot, int index) async {
    snapshot.data!.docs[index].reference.delete();

    notifyListeners();
  }

  // Delete note

  // ---------------

  // Create note

  void createNote(
      String titleController, String date, String contentController) async {
    try {
      FirebaseFirestore.instance.collection('Notes').add({
        'note_title': titleController,
        'creation_date': date,
        'note_content': contentController,
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // Create note

}

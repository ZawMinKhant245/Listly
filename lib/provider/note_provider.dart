
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:listly/models/note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> notes = [];

  final CollectionReference noteRef = FirebaseFirestore.instance.collection('notes');

  NoteProvider() {
    noteRef
        .orderBy('date', descending: true) //  sort newest first
        .snapshots()
        .listen((querySnapshot) {
      notes = querySnapshot.docs.map((doc) {
        return Note.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
      notifyListeners();
    });
  }

  Future<void> createNote(Note note) async {
    try {
      await noteRef.doc(note.id).set(note.toJson());
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  Future<void> updateNoteById(String noteId, Map<String, dynamic> json) async {
    try {
      await noteRef.doc(noteId).update(json);
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await noteRef.doc(id).delete();
    } catch (e) {
      debugPrint('Error deleting: $e');
    }
  }

  Future<Note?> getNoteById(String id) async {
    try {
      DocumentSnapshot doc = await noteRef.doc(id).get();
      if (doc.exists) {
        return Note.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint('Error : $e');
    }
    return null;
  }

  int getTotalMonth()  {
    int totalAmount = 0;

    for (var note in notes) {
      // Convert String to int safely
      int value = int.tryParse(note.total) ?? 0;
      totalAmount += value;
    }

    return totalAmount;
  }

  int getCurrentMonthTotal()  {
    int totalAmount = 0;
    final now = DateTime.now();

    for (var note in notes) {
      // Check if note.date is in the current month and year
      if (note.date.year == now.year && note.date.month == now.month) {
        int value = int.tryParse(note.total) ?? 0;
        totalAmount += value;
      }
    }

    return totalAmount;
  }


}

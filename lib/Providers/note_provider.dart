import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_notes/Models/note.dart';
import 'package:my_notes/Models/note_response.dart';
import 'package:my_notes/Services/note_services.dart';
import 'package:provider/provider.dart';

class NoteProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Note> notes = [];

  Future getAllNotes(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      var response =
          await Provider.of<NoteService>(context, listen: false).getNotesList();
      if (response.isSuccessful) {
        log(response.body.toString());
        notes.clear();
        NoteResponseModel noteResponseModel =
            NoteResponseModel.fromJson(response.body);
        notes.addAll(noteResponseModel.notes ?? []);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future getSingleNote(BuildContext context, Note note) async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await Provider.of<NoteService>(context, listen: false)
          .getNote(noteID: note.noteID!);
      if (response.isSuccessful) {
        note = Note.fromJson(response.body);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future createNote({
    required BuildContext context,
    required Note note,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      Map<String, dynamic> body = note.toJson();
      var response = await Provider.of<NoteService>(context, listen: false)
          .createNote(body: body);
      if (response.isSuccessful) {
        note = Note.fromJson(response.body);
        notes.add(note);
        notifyListeners();
      } else {
        SnackBar snackBar = const SnackBar(
          padding: EdgeInsets.all(20),
          backgroundColor: Colors.black,
          content: Text('Failed to create note !'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      SnackBar snackBar = const SnackBar(
        padding: EdgeInsets.all(20),
        backgroundColor: Colors.black,
        content: Text('Failed to create note !'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      rethrow;
    } finally {
      isLoading = false;
      getAllNotes(context);
      notifyListeners();
      Navigator.of(context).pop();
    }
  }

  Future deleteNote(BuildContext context, Note note) async {
    try {
      isLoading = true;
      notifyListeners();
      var response =
          await Provider.of<NoteService>(context, listen: false).deleteNote(
        noteID: note.noteID ?? '',
      );
      if (response.isSuccessful) {
        notes.remove(note);
        notifyListeners();
      }
    } catch (e) {
      SnackBar snackBar = const SnackBar(
        padding: EdgeInsets.all(20),
        backgroundColor: Colors.black,
        content: Text('Failed to delete note !'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
      Navigator.of(context).pop();
    }
  }

  Future updateNote({
    required BuildContext context,
    required Note note,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      Map<String, dynamic> body = note.toJson();
      var response =
          await Provider.of<NoteService>(context, listen: false).updateNote(
        noteID: note.noteID ?? '',
        body: body,
      );
      if (response.isSuccessful) {
        for (var element in notes) {
          if (element.noteID == note.noteID) {
            notes.remove(element);
            notes.add(note);
          }
        }
        notifyListeners();
      }
    } catch (e) {
      SnackBar snackBar = const SnackBar(
        padding: EdgeInsets.all(20),
        backgroundColor: Colors.black,
        content: Text('Failed to update note !'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      rethrow;
    } finally {
      isLoading = false;
      getAllNotes(context);
      notifyListeners();
      Navigator.of(context).pop();
    }
  }
}

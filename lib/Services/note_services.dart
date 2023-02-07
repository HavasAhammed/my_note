import 'dart:convert';

import 'package:my_notes/Models/api_response.dart';
import 'package:my_notes/Models/note.dart';
import 'package:my_notes/Models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:my_notes/Models/note_manipulation.dart';
import 'package:my_notes/Utils/api_const.dart';

class NoteService {
  static const headers = {
    'apiKey': '8ebfd7ef-6590-4ad3-bced-9eea05cae7f7',
    'Content-Type': 'application/json'
  };
  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http
        .get(Uri.parse(ApiConstants.notes), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonDate = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonDate) {
          notes.add(NoteForListing.fromJson(item));
        }
        return APIResponse<List<NoteForListing>>(
          data: notes,
        );
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
            error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<Note>> getNote(String noteID) {
    return http
        .get(Uri.parse('${ApiConstants.notes}/$noteID'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonDate = json.decode(data.body);

        return APIResponse<Note>(
          data: Note.fromJson(jsonDate),
        );
      }
      return APIResponse<Note>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<Note>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http
        .post(Uri.parse(ApiConstants.notes),
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http
        .put(Uri.parse('${ApiConstants.notes}/$noteID'),
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteNote(
    String noteID,
  ) {
    return http
        .delete(
      Uri.parse('${ApiConstants.notes}/$noteID'),
      headers: headers,
    )
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}

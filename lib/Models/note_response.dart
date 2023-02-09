// class APIResponse<T> {
//   T? data;
//   bool error;
//   String? errorMessage;
//   APIResponse({this.data, this.error = false, this.errorMessage});
// }

import 'package:my_notes/Models/note.dart';

class NoteResponseModel {
  List<Note>? notes;

  NoteResponseModel({this.notes});
  Map<String, dynamic> toJson() =>
      {'results': notes?.map((e) => e.toJson()).toList()};

  factory NoteResponseModel.fromJson(List<dynamic> json) => NoteResponseModel(
        notes: (json)
            .map((e) => Note.fromJson(e as Map<String, dynamic>))
            .toList()
      );
}

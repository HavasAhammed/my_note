// class Note {
//   String? noteID;
//   String? noteTitle;
//   String? noteContent;
//   DateTime? createDateTime;
//   DateTime? latestEditDateTime;

//   Note(
//       {this.noteID,
//       this.noteTitle,
//       this.noteContent,
//       this.createDateTime,
//       this.latestEditDateTime});

//   factory Note.fromJson(Map<String, dynamic> item) {
//     return Note(
//       noteID: item['noteID'],
//       noteTitle: item['noteTitle'],
//       noteContent: item['noteContent'],
//       createDateTime: DateTime.parse(item['createDateTime']),
//       latestEditDateTime: item['latestEditDateTime'] != null
//           ? DateTime.parse(item['latestEditDateTime'])
//           : null,
//     );
//   }
// }

class Note {
  String? _noteID;
  String? _noteTitle;
  String? _noteContent;
  DateTime? _createDateTime;
  DateTime? _latestEditDateTime;

  Note(
      {String? noteID,
      String? noteTitle,
      String? noteContent,
      DateTime? createDateTime,
      DateTime? latestEditDateTime}) {
    if (noteID != null) {
      _noteID = noteID;
    }
    if (noteTitle != null) {
      _noteTitle = noteTitle;
    }
    if (noteContent != null) {
      _noteContent = noteContent;
    }
    if (createDateTime != null) {
      _createDateTime = createDateTime;
    }
    if (latestEditDateTime != null) {
      _latestEditDateTime = latestEditDateTime;
    }
  }

  String? get noteID => _noteID;
  set noteID(String? noteID) => _noteID = noteID;
  String? get noteTitle => _noteTitle;
  set noteTitle(String? noteTitle) => _noteTitle = noteTitle;
  String? get noteContent => _noteContent;
  set noteContent(String? noteContent) => _noteContent = noteContent;
  DateTime? get createDateTime => _createDateTime;
  set createDateTime(DateTime? createDateTime) =>
      _createDateTime = createDateTime;
  DateTime? get latestEditDateTime => _latestEditDateTime;
  set latestEditDateTime(DateTime? latestEditDateTime) =>
      _latestEditDateTime = latestEditDateTime;

  Note.fromJson(Map<String, dynamic> json) {
    _noteID = json['noteID'];
    _noteTitle = json['noteTitle'];
    _noteContent = json['noteContent'];
    _createDateTime = DateTime.parse(json['createDateTime']);
    _latestEditDateTime =json['latestEditDateTime']==null?null: DateTime.parse(json['latestEditDateTime']) ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noteID'] = _noteID;
    data['noteTitle'] = _noteTitle;
    data['noteContent'] = _noteContent;
    data['createDateTime'] = _createDateTime;
    data['latestEditDateTime'] = _latestEditDateTime;
    return data;
  }
}

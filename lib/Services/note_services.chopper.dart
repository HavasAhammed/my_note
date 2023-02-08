// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$NoteService extends NoteService {
  _$NoteService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NoteService;

  @override
  Future<Response<List<NoteForListing>>> getNotesList() {
    final Uri $url = Uri.parse('');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<NoteForListing>, NoteForListing>($request);
  }

  @override
  Future<Response<Note>> getNote(String noteID) {
    final Uri $url = Uri.parse('{noteID}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Note, Note>($request);
  }

  @override
  Future<Response<bool>> createNote(NoteManipulation item) {
    final Uri $url = Uri.parse('');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<bool>> updateNote(
    String noteID,
    NoteManipulation item,
  ) {
    final Uri $url = Uri.parse('{noteID}');
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
    );
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<bool>> deleteNote(String noteID) {
    final Uri $url = Uri.parse('{noteID}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<bool, bool>($request);
  }
}

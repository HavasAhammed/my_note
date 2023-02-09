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
  Future<Response<dynamic>> getNotesList() {
    final Uri $url = Uri.parse('');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getNote({required String noteID}) {
    final Uri $url = Uri.parse('${noteID}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createNote({required Map<String, dynamic> body}) {
    final Uri $url = Uri.parse('');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateNote({
    required String noteID,
    required Map<String, dynamic> body,
  }) {
    final Uri $url = Uri.parse('${noteID}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteNote({required String noteID}) {
    final Uri $url = Uri.parse('${noteID}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}

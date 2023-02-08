import 'package:chopper/chopper.dart';
import 'package:my_notes/Interceptors/header_interceptors.dart';
import 'package:my_notes/Models/note.dart';
import 'package:my_notes/Models/note_for_listing.dart';
import 'package:my_notes/Models/note_manipulation.dart';
import 'package:my_notes/Utils/api_const.dart';

part 'note_services.chopper.dart';

@ChopperApi()
abstract class NoteService extends ChopperService {
  static const headers = {
    'apiKey': '8ebfd7ef-6590-4ad3-bced-9eea05cae7f7',
    'Content-Type': 'application/json'
  };

  // static NoteService create([ChopperClient? client]) => _$NoteService(client);

  @Get()
  Future<Response<List<NoteForListing>>> getNotesList();

  @Get(path: '{noteID}')
  Future<Response<Note>> getNote(String noteID);

  @Post()
  Future<Response<bool>> createNote(NoteManipulation item);

  @Put(path: '{noteID}')
  Future<Response<bool>> updateNote(String noteID, NoteManipulation item);

  @Delete(path: '{noteID}')
  Future<Response<bool>> deleteNote(String noteID);

  static NoteService create() {
    final client = ChopperClient(
        interceptors: [HeaderInterceptors()],
        baseUrl: Uri.parse(ApiConstants.notes),
        services: [_$NoteService()],
        converter: const JsonConverter());
    return _$NoteService(client);
  }
}

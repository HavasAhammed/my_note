import 'package:chopper/chopper.dart';
import 'package:my_notes/Interceptors/header_interceptors.dart';
import 'package:my_notes/Utils/api_const.dart';

part 'note_services.chopper.dart';

@ChopperApi()
abstract class NoteService extends ChopperService {
  @Get()
  Future<Response<dynamic>> getNotesList();

  @Get(path: '{noteID}')
  Future<Response<dynamic>> getNote({@Path('noteID') required String noteID});

  @Post()
  Future<Response<dynamic>> createNote(
      {@Body() required Map<String, dynamic> body});

  @Put(path: '{noteID}')
  Future<Response<dynamic>> updateNote(
      {@Path('noteID') required String noteID, 
      @Body() required Map<String, dynamic> body});

  @Delete(path: '{noteID}')
  Future<Response<dynamic>> deleteNote(
    {@Path('noteID') required String noteID}
  );

  static NoteService create() {
    final client = ChopperClient(
      interceptors: [
        HeaderInterceptors(),
      ],
      baseUrl: Uri.parse(ApiConstants.notes),
      services: [
        _$NoteService(),
      ],
      converter: const JsonConverter(),
    );
    return _$NoteService(client);
  }
}

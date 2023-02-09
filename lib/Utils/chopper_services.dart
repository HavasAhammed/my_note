import 'package:my_notes/Services/note_services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> chopperServices = [
  Provider(
    create: (context) => NoteService.create(),
    dispose: (_, NoteService services) => services.client.dispose(),
  )
];

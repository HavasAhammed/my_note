import 'package:my_notes/Providers/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider.value(
    value: NoteProvider(),
  )
];

import 'package:flutter/material.dart';
import 'package:my_notes/Interfaces/Screens/Note%20List%20Screen/note_list_screen.dart';
import 'package:my_notes/Utils/chopper_services.dart';
import 'package:my_notes/Utils/providers.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...chopperServices,
        ...providers,
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // brightness: Brightness.dark,
            primarySwatch: Colors.blue,
          ),
          home: const NoteListScreen()),
    );
  }
}

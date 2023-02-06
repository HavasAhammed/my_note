import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_notes/Services/note_services.dart';
import 'package:my_notes/app.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NoteService());
}

void main() {
  setupLocator();
  runApp(const MyApp());
}

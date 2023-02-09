import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_notes/app.dart';
import 'package:logging/logging.dart';

void main() {
  _setupLogging();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    log('${rec.level.name} : ${rec.time} : ${rec.message}');
  });
}

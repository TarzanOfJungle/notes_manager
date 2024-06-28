import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_manager/common/constants/hive_constants.dart';

import '../../notes/models/note.dart';

abstract class Startup {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await _initBoxes();
    await Hive.openBox<Note>(HiveConstants.notesBoxKey);
  }
  static Future<void> _initBoxes() async {
    Hive.registerAdapter(NoteAdapter());
  }
}
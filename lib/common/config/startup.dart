import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

import '../../notes/models/note.dart';

abstract class Startup {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await _initBoxes();
  }

  static Future<void> _initBoxes() async {
    Hive.registerAdapter(NoteAdapter());
  }
}
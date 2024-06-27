import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_manager/common/constants/hive_constants.dart';

import '../../notes/models/note.dart';

abstract class Startup {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await _initBoxes();
    await Hive.openBox<Note>(HiveConstants.NOTES_BOX_KEY);

    var lifecycleObserver = _AppLifecycleObserver();
    WidgetsBinding.instance.addObserver(lifecycleObserver);
  }
  static Future<void> _initBoxes() async {
    Hive.registerAdapter(NoteAdapter());
  }
}

class _AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      Hive.close(); // Close Hive when the app is paused or terminated
    }
  }
}
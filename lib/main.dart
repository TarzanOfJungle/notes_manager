import 'package:flutter/material.dart';
import 'package:notes_manager/notes/screens/notes_page.dart';

void main() {
  runApp(const NotesManagerApp());
}

class NotesManagerApp extends StatelessWidget {
  const NotesManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Manager',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const NotesPage(),
    );
  }
}

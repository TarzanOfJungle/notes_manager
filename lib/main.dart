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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NotesPage(),
    );
  }
}

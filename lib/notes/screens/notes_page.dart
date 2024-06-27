import 'package:flutter/material.dart';
import 'package:notes_manager/notes/widgets/note_tile.dart';

import '../models/note.dart';

class NotesPage extends StatelessWidget {
  NotesPage({super.key});

  final List<Note> notes = [
    Note(title: 'Note 1', isImportant: true, isResolved: false, description: "blabla"),
    Note(title: "NoteNote", isImportant: false, isResolved: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: Center(
        child: Column(
          children: notes.map((note) => NoteTile(onEdit: () => {}, note: note)).toList(),
        ),
      ),
    );
  }
}

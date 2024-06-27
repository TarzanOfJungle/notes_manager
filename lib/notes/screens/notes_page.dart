import 'package:flutter/material.dart';
import 'package:notes_manager/notes/widgets/note_tile.dart';

import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _newNoteTitleController = TextEditingController();

  final _newNoteDescriptionController = TextEditingController();

  bool _newNoteIsImportant = false;

  final List<Note> _notes = [
    Note(title: 'Note 1',
        isImportant: true,
        isResolved: false,
        description: "blabla"),
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
          children: [
            const Text("New Note:"),
            TextField(
              controller: _newNoteTitleController,
              decoration: const InputDecoration(labelText: "Title:"),

            ),
            TextField(
              controller: _newNoteDescriptionController,
              decoration: const InputDecoration(labelText: "Description:"),
            ),
            Switch(value: _newNoteIsImportant,
                onChanged: (_) => setState(() {
                  _newNoteIsImportant = !_newNoteIsImportant;
                })),
            ElevatedButton(
                onPressed: () => setState(() {
                  _notes.add(Note(title: _newNoteTitleController.text,
                      description: _newNoteDescriptionController.text,
                      isImportant: _newNoteIsImportant,
                      isResolved: false));
                }),
                child: const Text("Add Note")),
            ..._notes.map((note) => NoteTile(onEdit: () => {}, note: note))
                .toList(),
          ],
        ),
      ),
    );
  }
}

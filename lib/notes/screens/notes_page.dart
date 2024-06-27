import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_manager/notes/widgets/dialogs/note_dialog.dart';
import 'package:notes_manager/notes/widgets/note_tile.dart';

import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> _notes = [
    Note(
        id: "id1",
        title: 'Note 1',
        isImportant: true,
        isResolved: false,
        description: "blabla"),
    Note(id: "id2", title: "NoteNote", isImportant: false, isResolved: false)
  ];


  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(
              onPressed: () => _onNewButtonPressed(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [_buildNotesDisplay(_notes)],
        ),
      ),
    );
  }

  Widget _buildNotesDisplay(List<Note> notes) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final note = notes[index];
        return NoteTile(
            onEdit: () => _onEditButtonPressed(context, note),
            onDelete: () {
              _deleteNoteById(note.id);
            },
            note: note);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 10.0);
      },
      itemCount: notes.length,
    );
  }

  void _onNewButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => NoteDialog(
        onConfirm: (Note newNote) => setState(() {
          _notes.add(newNote);
        }),
      ),
    );
  }

  void _onEditButtonPressed(BuildContext context, Note note) {
    showDialog(
        context: context,
        builder: (context) => NoteDialog(
            note: note,
            onConfirm: (Note updatedNote) => setState(() {
                  int index = _notes.indexWhere((n) => n.id == updatedNote.id);
                  if (index != -1) {
                    _notes[index] = updatedNote;
                  }
                })));
  }

  void _deleteNoteById(String id) {
    setState(() {
      _notes.removeWhere((note) => note.id == id);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_manager/common/constants/hive_constants.dart';
import 'package:notes_manager/notes/widgets/dialogs/note_dialog.dart';
import 'package:notes_manager/notes/widgets/note_tile.dart';

import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _notesBox = Hive.box<Note>(HiveConstants.NOTES_BOX_KEY);

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
          _addNote(newNote);
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
                  _editNote(updatedNote);
                })));
  }

  List<Note> get _notes => _notesBox.values.toList();

  void _addNote(Note newNote) {
    _notesBox.put(newNote.id, newNote);
  }

  void _editNote(Note updatedNote) {
    _notesBox.put(updatedNote.id, updatedNote);
  }

  void _deleteNoteById(String id) {
    setState(() {
      _notesBox.delete(id);
    });
  }
}

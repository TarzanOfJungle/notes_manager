import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_manager/common/constants/hive_constants.dart';
import 'package:notes_manager/notes/widgets/dialogs/note_dialog.dart';
import 'package:notes_manager/notes/widgets/note_tile.dart';

import '../models/note.dart';

class NotesPage extends StatelessWidget {
  NotesPage({super.key});
  final _notesBox = Hive.box<Note>(HiveConstants.NOTES_BOX_KEY);

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
          children: [
            ValueListenableBuilder(
                valueListenable: _notesBox.listenable(),
                builder: (context, _notesBox, _) {
                  final notes = _notes;
                  return _buildNotesDisplay(notes);
                }
            ),
          ],
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
        onConfirm: (Note newNote) => _addNote(newNote)
      ),
    );
  }

  void _onEditButtonPressed(BuildContext context, Note note) {
    showDialog(
        context: context,
        builder: (context) => NoteDialog(
            note: note,
            onConfirm: (Note updatedNote) => _editNote(updatedNote)));
  }

  List<Note> get _notes {
    List<Note> notesList = _notesBox.values.toList();
    notesList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return notesList;
  }

  void _addNote(Note newNote) {
    _notesBox.put(newNote.id, newNote);
  }

  void _editNote(Note updatedNote) {
    _notesBox.put(updatedNote.id, updatedNote);
  }

  void _deleteNoteById(String id) => _notesBox.delete(id);
}

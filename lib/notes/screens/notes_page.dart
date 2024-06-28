import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_manager/common/constants/hive_constants.dart';
import 'package:notes_manager/common/widgets/switch_with_label.dart';
import 'package:notes_manager/notes/widgets/dialogs/note_dialog.dart';
import 'package:notes_manager/notes/widgets/note_tile.dart';

import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _notesBox = Hive.box<Note>(HiveConstants.notesBoxKey);
  bool _showOnlyImportant = false;
  bool _showResolved = false;

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
          _buildFilterSection(),
          IconButton(
              onPressed: () => _onNewButtonPressed(context),
              icon: const Icon(
                Icons.add,
                size: 35,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: _notesBox.listenable(),
                builder: (context, notesBox, _) {
                  final notes = _notes;
                  return _buildNotesDisplay(notes);
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Row(
      children: [
        SwitchWithLabel(
            value: _showOnlyImportant,
            onChanged: (_) => setState(() {
                  _showOnlyImportant = !_showOnlyImportant;
                }),
            title: "Only important"),
        SwitchWithLabel(
            value: _showResolved,
            onChanged: (_) => setState(() {
                  _showResolved = !_showResolved;
                }),
            title: "Resolved"),
      ],
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
            onResolve: () => _onResolveButtonPressed(note),
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
      builder: (context) =>
          NoteDialog(onConfirm: (Note newNote) => _addNote(newNote)),
    );
  }

  void _onEditButtonPressed(BuildContext context, Note note) {
    showDialog(
        context: context,
        builder: (context) => NoteDialog(
            note: note,
            onConfirm: (Note updatedNote) => _editNote(updatedNote)));
  }

  void _onResolveButtonPressed(Note note) {
    _editNote(Note(
        id: note.id,
        title: note.title,
        isImportant: note.isImportant,
        isResolved: true,
        createdAt: note.createdAt,
        updatedAt: DateTime.now()));
  }

  List<Note> get _notes {
    List<Note> notesList = _notesBox.values.toList();
    notesList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    notesList = notesList
        .where((note) => _showOnlyImportant ? note.isImportant : true)
        .where((note) => !_showResolved ? !note.isResolved : true)
        .toList();

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

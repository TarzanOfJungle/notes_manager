import 'package:flutter/material.dart';
import 'package:notes_manager/common/widgets/dialogs/notes_manager_dialog.dart';
import 'package:uuid/uuid.dart';

import '../../models/note.dart';

class NoteDialog extends StatefulWidget {
  final void Function(Note) onConfirm;
  final Note? note; // If no note is provided it works as dialog to create new one

  const NoteDialog({super.key, required this.onConfirm, this.note});

  @override
  State<NoteDialog> createState() => _NewNoteDialogState();
}

class _NewNoteDialogState extends State<NoteDialog> {
  final _uuid = const Uuid();
  final _newNoteTitleController = TextEditingController();
  final _newNoteDescriptionController = TextEditingController();
  bool _newNoteIsImportant = false;


  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      _newNoteTitleController.text = widget.note!.title;
      _newNoteDescriptionController.text = widget.note!.description ?? '';
      _newNoteIsImportant = widget.note!.isImportant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotesManagerDialog(
      title: widget.note == null ? 'New Note' : 'Edit Note',
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _newNoteTitleController,
          decoration: const InputDecoration(labelText: "Title:"),
        ),
        TextField(
          controller: _newNoteDescriptionController,
          decoration: const InputDecoration(labelText: "Description:"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Important?'),
            Switch(
                value: _newNoteIsImportant,
                onChanged: (_) => setState(() {
                      _newNoteIsImportant = !_newNoteIsImportant;
                    })),
          ],
        ),
        _buildDialogButtons(context),
      ],
    );
  }

  Widget _buildDialogButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 25),
        ElevatedButton(
            onPressed: () {
              widget.onConfirm(Note(
                  id: _creatingNewNote ? _uuid.v4() : widget.note!.id,
                  title: _newNoteTitleController.text,
                  description: _newNoteDescriptionController.text,
                  isImportant: _newNoteIsImportant,
                  isResolved: false, //TODO use this
                  createdAt: _creatingNewNote ? DateTime.timestamp() : widget.note!.createdAt,
                  updatedAt: _creatingNewNote ? null : DateTime.timestamp(),
              ));
              Navigator.of(context).pop();
            },
            child: Text(_creatingNewNote ? 'Add Note' : 'Save Changes')),
      ],
    );
  }

  bool get _creatingNewNote => widget.note == null;
}

import 'package:flutter/material.dart';
import 'package:notes_manager/common/widgets/dialogs/notes_manager_dialog.dart';
import 'package:uuid/uuid.dart';

import '../../models/note.dart';

class NewNoteDialog extends StatefulWidget {
  final void Function(Note) onConfirm;

  const NewNoteDialog({super.key, required this.onConfirm});

  @override
  State<NewNoteDialog> createState() => _NewNoteDialogState();
}

class _NewNoteDialogState extends State<NewNoteDialog> {
  final _uuid = const Uuid();
  final _newNoteTitleController = TextEditingController();
  final _newNoteDescriptionController = TextEditingController();
  bool _newNoteIsImportant = false;

  @override
  Widget build(BuildContext context) {
    return NotesManagerDialog(
      title: 'New Note',
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
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
        ElevatedButton(onPressed: () {
          widget.onConfirm(Note(
              id: _uuid.v4(),
              title: _newNoteTitleController.text,
              description: _newNoteDescriptionController.text,
              isImportant: _newNoteIsImportant,
              isResolved: false));
          Navigator.of(context).pop();
        }, child: const Text("Add Note")),
      ],
    );
  }
}

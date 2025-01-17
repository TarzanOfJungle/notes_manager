import 'package:flutter/material.dart';
import 'package:notes_manager/common/constants/ui_constants.dart';
import 'package:notes_manager/common/widgets/dialogs/notes_manager_dialog.dart';
import 'package:uuid/uuid.dart';

import '../../models/note.dart';

class NoteDialog extends StatefulWidget {
  final void Function(Note) onConfirm;
  final Note?
      note; // If no note is provided it works as dialog to create new one

  const NoteDialog({super.key, required this.onConfirm, this.note});

  @override
  State<NoteDialog> createState() => _NewNoteDialogState();
}

class _NewNoteDialogState extends State<NoteDialog> {
  final _uuid = const Uuid();
  final _newNoteTitleController = TextEditingController();
  bool _validTitle = true;
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
          decoration: InputDecoration(
            labelText: "Title:",
            errorText: _validTitle ? null : "Title Can't Be Empty",
          ),
          maxLength: 60,
        ),
        TextField(
          controller: _newNoteDescriptionController,
          decoration: const InputDecoration(labelText: "Description:"),
          maxLength: 500,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Important'),
            const SizedBox(width: 10.0),
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
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all(UiConstants.whiteColor),
              backgroundColor: MaterialStateProperty.all(
                UiConstants.deleteColor,
              )),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 25),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _validTitle = _newNoteTitleController.text.isNotEmpty;
              });
              if (!_validTitle) return;

              widget.onConfirm(Note(
                id: _creatingNewNote ? _uuid.v4() : widget.note!.id,
                title: _newNoteTitleController.text,
                description: _newNoteDescriptionController.text,
                isImportant: _newNoteIsImportant,
                isResolved: _creatingNewNote ? false : widget.note!.isResolved,
                createdAt:
                    _creatingNewNote ? DateTime.now() : widget.note!.createdAt,
                updatedAt: _creatingNewNote ? null : DateTime.now(),
              ));
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all(UiConstants.whiteColor),
                backgroundColor:
                    MaterialStateProperty.all(UiConstants.confirmColor)),
            child: Text(_creatingNewNote ? 'Add Note' : 'Save Changes')),
      ],
    );
  }

  bool get _creatingNewNote => widget.note == null;
}

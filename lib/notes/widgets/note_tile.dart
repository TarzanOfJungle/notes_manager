import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_manager/common/constants/ui_constants.dart';
import 'package:notes_manager/notes/models/note.dart';

const _IMPORTANT_NOTE_COLOR = Color(0xFFFFECB3);
const _DEFAULT_NOTE_COLOR = Color(0xFFE8E8E8);

class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onResolve;

  const NoteTile(
      {super.key,
      required this.onEdit,
      required this.note,
      required this.onDelete,
      required this.onResolve});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UiConstants.standardBorderRadius),
        color: note.isImportant ? _IMPORTANT_NOTE_COLOR : _DEFAULT_NOTE_COLOR,
      ),
      child: Padding(
        padding: const EdgeInsets.all(UiConstants.standardPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  note.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit',
                ),
                IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete),
                    tooltip: 'Delete'),
                if (!note.isResolved)
                  IconButton(
                    onPressed: onResolve,
                    icon: const Icon(Icons.check),
                    tooltip: 'Resolve'),
              ],
            ),
            if (note.description != null && note.description!.isNotEmpty)
              Text(note.description!),
            _buildTimestampDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimestampDisplay() {
    final df = DateFormat('dd-MM-yyyy hh:mm a');
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        note.updatedAt == null
            ? 'Created at: ${df.format(note.createdAt)}'
            : 'Updated at: ${df.format(note.updatedAt!)}',
        style: const TextStyle(fontSize: UiConstants.smallFontSize),
      ),
    );
  }
}

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

  const NoteTile({super.key,
    required this.onEdit,
    required this.note,
    required this.onDelete,
    required this.onResolve});

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  UiConstants.standardBorderRadius),
              color: note.isImportant
                  ? _IMPORTANT_NOTE_COLOR
                  : _DEFAULT_NOTE_COLOR,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: UiConstants.standardPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _buildTitleDisplayWithActions(),
                      const SizedBox(height: UiConstants.standardPadding,),
                      if (note.description != null &&
                          note.description!.isNotEmpty)
                        Text(note.description!),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimestampDisplay(),
                      IconButton(
                          onPressed: onDelete,
                          icon: const Icon(Icons.delete),
                          tooltip: 'Delete'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]
    );
  }

  Widget _buildTitleDisplayWithActions() {
    return SizedBox(
      height: 40.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              note.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _buildActionsOrResolvedIndicator(),
        ],
      ),
    );
  }

  Widget _buildActionsOrResolvedIndicator() {
    if (note.isResolved) {
      return const Text('RESOLVED', style: TextStyle(fontWeight: FontWeight.bold),);
    }

    return Row(
      children: [
        IconButton(
          onPressed: onEdit,
          icon: const Icon(Icons.edit),
          tooltip: 'Edit',
        ),
        IconButton(
            onPressed: onResolve,
            icon: const Icon(Icons.check),
            tooltip: 'Resolve'),
      ],
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

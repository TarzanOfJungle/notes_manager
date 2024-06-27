import 'package:flutter/material.dart';
import 'package:notes_manager/notes/models/note.dart';

const _IMPORTANT_COLOR = Color(0xFFFFECB3);
class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const NoteTile(
      {super.key,
      required this.onEdit,
      required this.note,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: note.isImportant ? _IMPORTANT_COLOR : DefaultSelectionStyle.defaultColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold),),
                IconButton(onPressed: onEdit, icon: const Icon(Icons.edit), tooltip: 'Edit',),
                IconButton(onPressed: onDelete, icon: const Icon(Icons.delete), tooltip: 'Delete'),
              ],
            ),
            if (note.description != null && note.description!.isNotEmpty)
              Text(note.description!),
          ],
        ),
      ),
    );
  }
}

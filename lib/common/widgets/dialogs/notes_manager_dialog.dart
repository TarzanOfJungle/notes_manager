import 'package:flutter/material.dart';

class NotesManagerDialog extends StatelessWidget {
  final String title;
  final Widget body;
  const NotesManagerDialog({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 25,
        ),
        child: Column(
          children: [
            _buildTitle(context),
            const SizedBox(height: 25),
            body,
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Flexible(
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

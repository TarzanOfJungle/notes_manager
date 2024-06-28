import 'package:flutter/material.dart';

import '../constants/ui_constants.dart';

class SwitchWithLabel extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  final String title;

  const SwitchWithLabel(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: value,
            onChanged: onChanged,
          ),
        ),
        Text(title,
            style: const TextStyle(
              fontSize: UiConstants.smallFontSize,
            )),
      ],
    );
    ;
  }
}

import 'package:flutter/material.dart';

import '../third_page_inherited_notifier.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final isEnabledProperty =
        ThirdPageInheritedNotifier.watchNotifier(context).isEnabledProperty;
    final inputProperty =
        ThirdPageInheritedNotifier.readNotifier(context).inputProperty;

    return SizedBox(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Enter the Value',
          errorText: inputProperty.hasErrors ? inputProperty.errors[0] : null,
        ),
        enabled: isEnabledProperty.value,
        controller: controller,
        onChanged: (text) {
          inputProperty.value = text;
        },
      ),
    );
  }
}

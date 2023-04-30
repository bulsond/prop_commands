import 'package:flutter/material.dart';

import 'third_page_inherited_notifier.dart';
import 'widget/input_text_widget.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabledProperty =
        ThirdPageInheritedNotifier.watchNotifier(context).isEnabledProperty;
    final outputProperty =
        ThirdPageInheritedNotifier.watchNotifier(context).outputProperty;
    final submitCommand =
        ThirdPageInheritedNotifier.readNotifier(context).submitCommand;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CheckboxListTile(
            title: const Text('enable the input line'),
            controlAffinity: ListTileControlAffinity.platform,
            contentPadding: const EdgeInsets.all(50),
            value: isEnabledProperty.value,
            onChanged: (value) {
              isEnabledProperty.value = value!;
            },
          ),
          const SizedBox(height: 50),
          InputTextWidget(
            controller: controller,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: submitCommand.canExecute()
                ? (() async {
                    await submitCommand.execute();
                    controller.clear();
                  })
                : null,
            child: const Icon(Icons.done),
          ),
          const SizedBox(height: 50),
          Text(outputProperty.value),
        ],
      ),
    );
  }
}

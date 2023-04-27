import 'package:flutter/material.dart';

import '../fourth_page_inherited_notifier.dart';

class ComposeWidget extends StatefulWidget {
  const ComposeWidget({super.key});

  @override
  State<ComposeWidget> createState() => _ComposeWidgetState();
}

class _ComposeWidgetState extends State<ComposeWidget> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final command =
        FourthPageInheritedNotifier.readNotifier(context).addCommand;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(hintText: 'Enter first name'),
          ),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(hintText: 'Enter last name'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () async {
                final names = <String>[
                  _firstNameController.text,
                  _lastNameController.text,
                ];
                await command(names);
                _firstNameController.text = '';
                _lastNameController.text = '';
              },
              child: Text(
                'Add to list',
                style: Theme.of(context).textTheme.titleMedium,
              ))
        ],
      ),
    );
  }
}

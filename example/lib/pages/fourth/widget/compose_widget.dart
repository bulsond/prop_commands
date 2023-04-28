import 'package:flutter/material.dart';

import '../fourth_page_inherited_notifier.dart';

class ComposeWidget extends StatelessWidget {
  const ComposeWidget({
    required this.firstNameController,
    required this.lastNameController,
    super.key,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    final command =
        FourthPageInheritedNotifier.readNotifier(context).addCommand;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: firstNameController,
            decoration: const InputDecoration(hintText: 'Enter first name'),
          ),
          TextField(
            controller: lastNameController,
            decoration: const InputDecoration(hintText: 'Enter last name'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () async {
                final names = <String>[
                  firstNameController.text,
                  lastNameController.text,
                ];
                await command(names);
                firstNameController.clear();
                lastNameController.clear();
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

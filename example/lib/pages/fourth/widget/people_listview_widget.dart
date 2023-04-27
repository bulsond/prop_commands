import 'package:flutter/material.dart';

import '../fourth_page_inherited_notifier.dart';
import '../model/person.dart';

class PeopleListViewWidget extends StatelessWidget {
  const PeopleListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final people =
        FourthPageInheritedNotifier.watchNotifier(context).peopleProperty.value;
    final removeCommand =
        FourthPageInheritedNotifier.watchNotifier(context).removeCommand;
    final updateCommand =
        FourthPageInheritedNotifier.watchNotifier(context).updateCommand;

    return Expanded(
      child: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            onTap: () async {
              final editedPerson = await showUpdateDialog(context, person);
              if (editedPerson == null) return;
              await updateCommand(editedPerson);
            },
            title: Text(person.fullName),
            subtitle: Text('ID: ${person.id}'),
            trailing: TextButton(
                onPressed: () async {
                  final shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete) {
                    await removeCommand(person.id);
                  }
                },
                child: const Icon(
                  Icons.disabled_by_default_rounded,
                  color: Colors.red,
                )),
          );
        },
      ),
    );
  }
}

Future<bool> showDeleteDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Delete'),
            )
          ],
        );
      }).then((value) {
    if (value is bool) {
      return value;
    } else {
      return false;
    }
  });
}

final _firstNameController = TextEditingController();
final _lastNameController = TextEditingController();

Future<Person?> showUpdateDialog(BuildContext context, Person person) {
  _firstNameController.text = person.firstName;
  _lastNameController.text = person.lastName;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter your updated values here:'),
            TextField(
              controller: _firstNameController,
            ),
            TextField(
              controller: _lastNameController,
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                final editedPerson = Person(
                  id: person.id,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                );
                Navigator.of(context).pop(editedPerson);
              },
              child: const Text('Save')),
        ],
      );
    },
  ).then((value) {
    if (value is Person) {
      return value;
    } else {
      return null;
    }
  });
}

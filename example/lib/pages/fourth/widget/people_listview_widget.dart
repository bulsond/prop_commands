import 'package:flutter/material.dart';

import '../fourth_page_inherited_notifier.dart';
import '../model/person.dart';

class PeopleListViewWidget extends StatelessWidget {
  const PeopleListViewWidget({
    required this.firstNameController,
    required this.lastNameController,
    super.key,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    final people =
        FourthPageInheritedNotifier.watchNotifier(context).peopleProperty.value;
    final removeCommand =
        FourthPageInheritedNotifier.readNotifier(context).removeCommand;
    final updateCommand =
        FourthPageInheritedNotifier.readNotifier(context).updateCommand;

    return Expanded(
      child: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            onTap: () async {
              firstNameController.text = person.firstName;
              lastNameController.text = person.lastName;
              final editedPerson = await showUpdateDialog(
                context,
                firstNameController,
                lastNameController,
                person.id,
              );
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

Future<Person?> showUpdateDialog(
  BuildContext context,
  TextEditingController firstNameController,
  TextEditingController lastNameController,
  int personId,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter your updated values here:'),
            TextField(
              controller: firstNameController,
            ),
            TextField(
              controller: lastNameController,
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
                  id: personId,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                );
                firstNameController.clear();
                lastNameController.clear();
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

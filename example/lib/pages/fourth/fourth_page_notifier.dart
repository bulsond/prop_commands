import 'package:flutter/material.dart';
import 'package:prop_commands/prop_commands.dart';

import 'data/person_db.dart';
import 'model/person.dart';

class FourthPageNotifier extends ChangeNotifier {
  FourthPageNotifier({required PersonDb personDb}) : _db = personDb;

  final PersonDb _db;

  Future<bool> loadPeople() async {
    final people = await _db.getPeople();
    peopleProperty.value = people;
    return true;
  }

  final peopleProperty = Property<List<Person>>(
    initialValue: <Person>[],
  );

  late final addCommand = ParameterizedAsyncCommand<List<String>>(
    action: (value) async {
      await _db.create(names: value);
      peopleProperty.value = await _db.getPeople();
    },
    notifyListeners: notifyListeners,
  );

  late final removeCommand = ParameterizedAsyncCommand<int>(
    action: (value) async {
      await _db.remove(id: value);
      peopleProperty.value = await _db.getPeople();
    },
    notifyListeners: notifyListeners,
  );

  late final updateCommand = ParameterizedAsyncCommand<Person>(
    action: (value) async {
      await _db.update(person: value);
      peopleProperty.value = await _db.getPeople();
    },
    notifyListeners: notifyListeners,
  );
}

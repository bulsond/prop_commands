import '../model/person.dart';

class PersonDb {
  PersonDb();

  final _people = <Person>[
    Person(id: 1, firstName: 'Walter', lastName: 'White'),
    Person(id: 2, firstName: 'Saul', lastName: 'Goodman'),
    Person(id: 3, firstName: 'Jesse', lastName: 'Pinkman'),
    Person(id: 5, firstName: 'Skyler', lastName: 'White'),
    Person(id: 6, firstName: 'Hank', lastName: 'Schrader'),
    Person(id: 7, firstName: 'Marie', lastName: 'Schrader'),
    Person(id: 8, firstName: 'Mike', lastName: 'Ehrmantraut'),
    Person(id: 9, firstName: 'Gus', lastName: 'Fring'),
    Person(id: 10, firstName: 'Todd', lastName: 'Alquist'),
    Person(id: 11, firstName: 'Lydia', lastName: 'Rodarte-Quayle'),
    Person(id: 12, firstName: 'Skinny', lastName: 'Pete'),
    Person(id: 13, firstName: 'Jane', lastName: 'Margolis'),
    Person(id: 14, firstName: 'Hector', lastName: 'Salamanca'),
  ];

  Future<List<Person>> getPeople() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List<Person>.from(_people.reversed);
  }

  Future<int> create({required List<String> names}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var id = 1;
    if (_people.isNotEmpty) {
      id = _people.last.id + 1;
    }
    final person = Person(id: id, firstName: names[0], lastName: names[1]);
    _people.add(person);
    return id;
  }

  Future<bool> remove({required int id}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final person = _people.singleWhere((element) => element.id == id);
    return _people.remove(person);
  }

  Future<void> update({required Person person}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var index = _people.indexWhere((element) => element.id == person.id);
    _people[index] = _people[index].copyWith(
      id: person.id,
      firstName: person.firstName,
      lastName: person.lastName,
    );
  }
}

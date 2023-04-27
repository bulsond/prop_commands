class Person {
  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final int id;
  final String firstName;
  final String lastName;
  String get fullName => '$firstName $lastName';

  @override
  String toString() =>
      'Person(id: $id, firstName: $firstName, lastName: $lastName)';

  Person copyWith({
    int? id,
    String? firstName,
    String? lastName,
  }) {
    return Person(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}

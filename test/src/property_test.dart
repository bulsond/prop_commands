import 'package:test/test.dart';
import 'package:prop_commands/prop_commands.dart';

class TestListener {
  TestListener();

  bool wasCalled = false;

  void notifyListeners() {
    wasCalled = true;
  }
}

void main() {
  group('Property<String>', () {
    const valueBeforeChange = 'before change';
    const valueAfterChange = 'after change';
    late TestListener listener;
    late Map<String, bool Function(String value)> verificationRules;
    late Property<String> sut;

    Map<String, bool Function(String value)> collectRules() {
      return <String, bool Function(String value)>{
        'the value cannot be an empty string': (value) => value.isEmpty,
        'the length of the string cannot be less than 5 characters': (value) =>
            value.length < 5,
      };
    }

    setUp(() {
      listener = TestListener();
      verificationRules = collectRules();
      sut = Property(
        initialValue: valueBeforeChange,
        notifyListeners: listener.notifyListeners,
        verificationRules: verificationRules,
      );
    });

    test('after creation, the value of the property is "before change"', () {
      expect(sut.value, isA<String>());
      expect(sut.value, equals('before change'));
    });
    test('''assigning a new value changes the value of
        the property to "after change" and calls the method notifyListeners()''',
        () {
      expect(listener.wasCalled, false);
      sut.value = valueAfterChange;
      expect(sut.value, equals(valueAfterChange));
      expect(listener.wasCalled, true);
    });
    test('''after creating a property with the correct value
        hasErrors equals false and the error list is empty''', () {
      expect(sut.hasErrors, false);
      expect(sut.errors.isEmpty, true);
    });
    test('''after creating a property with an invalid empty value
        hasErrors equals true and the error list is not empty,
        but contains a single value
        equal "the value cannot be an empty string"''', () {
      sut = Property(
        initialValue: '',
        notifyListeners: listener.notifyListeners,
        verificationRules: verificationRules,
      );
      expect(sut.hasErrors, true);
      expect(sut.errors.isNotEmpty, true);
      expect(sut.errors[0], equals('the value cannot be an empty string'));
    });
    test('''after changing the value to incorrect
        hasErrors equals true and the error contains the value
        equal "the length of the string cannot be less than 5 characters"''',
        () {
      sut.value = 'err';
      expect(sut.hasErrors, true);
      expect(sut.errors[0],
          equals('the length of the string cannot be less than 5 characters'));
    });
  });
}

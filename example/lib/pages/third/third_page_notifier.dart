import 'package:flutter/material.dart';
import 'package:prop_commands/prop_commands.dart';

class ThirdPageNotifier extends ChangeNotifier {
  ThirdPageNotifier();

  late final isEnabledProperty = Property<bool>(
    initialValue: false,
    notifyListeners: notifyListeners,
  );

  late final inputProperty = Property<String>(
    initialValue: '',
    notifyListeners: notifyListeners,
    verificationRules: <String, bool Function(String)>{
      'The value cannot be an empty string': (value) => value.isEmpty,
      'The length of the string cannot be less than 3 characters': (value) =>
          value.length < 3,
    },
  );

  final outputProperty = Property<String>(initialValue: '');

  late final submitCommand = AsyncCommand(
    action: () async {
      await Future.delayed(const Duration(milliseconds: 100));
      outputProperty.value = inputProperty.value;
      inputProperty.value = '';
      isEnabledProperty.value = false;
    },
    canAction: () => inputProperty.hasErrors == false,
    notifyListeners: notifyListeners,
  );
}

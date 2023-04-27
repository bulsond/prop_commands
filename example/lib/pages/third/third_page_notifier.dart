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
  );

  late final outputProperty = Property<String>(initialValue: '');

  late final submitCommand = AsyncCommand(
    action: () async {
      await Future.delayed(const Duration(milliseconds: 100));
      outputProperty.value = inputProperty.value;
      inputProperty.value = '';
      isEnabledProperty.value = false;
    },
    canAction: () => inputProperty.value.length > 3,
    notifyListeners: notifyListeners,
  );
}

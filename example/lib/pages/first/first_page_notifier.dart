import 'package:flutter/material.dart';
import 'package:prop_commands/prop_commands.dart';

class FirstPageNotifier extends ChangeNotifier {
  FirstPageNotifier();

  late final outputProperty = Property<int>(
    initialValue: 0,
    notifyListeners: notifyListeners,
  );

  late final incrementCommand = Command(
    action: () => outputProperty.value += 1,
    canAction: () => outputProperty.value < 3,
  );

  late final decrementCommand = Command(
    action: () => outputProperty.value -= 1,
    canAction: () => outputProperty.value > 0,
  );
}

import 'package:flutter/material.dart';
import 'package:prop_commands/prop_commands.dart';

class SecondPageNotifier extends ChangeNotifier {
  SecondPageNotifier();

  final outputProperty = Property<int>(initialValue: 0);

  late final changeCommand = ParameterizedCommand<int>(
    action: (value) => outputProperty.value += value,
    notifyListeners: notifyListeners,
  );
}

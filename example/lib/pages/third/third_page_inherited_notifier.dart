import 'package:flutter/material.dart';

import 'third_page_notifier.dart';

class ThirdPageInheritedNotifier extends InheritedNotifier<ThirdPageNotifier> {
  const ThirdPageInheritedNotifier({
    Key? key,
    required ThirdPageNotifier notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static ThirdPageNotifier watchNotifier(BuildContext context) {
    var inheritedNotifier = context
        .dependOnInheritedWidgetOfExactType<ThirdPageInheritedNotifier>();
    assert(inheritedNotifier != null,
        'InheritedNotifier not found in the watchNotifier method');
    return inheritedNotifier!.notifier!;
  }

  static ThirdPageNotifier readNotifier(BuildContext context) {
    var inheritedNotifier = context
        .getElementForInheritedWidgetOfExactType<ThirdPageInheritedNotifier>();
    assert(inheritedNotifier != null,
        'InheritedNotifier not found in the readNotifier method');
    return (inheritedNotifier!.widget as ThirdPageInheritedNotifier).notifier!;
  }
}

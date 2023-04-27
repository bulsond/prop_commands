import 'package:flutter/material.dart';

import 'first_page_notifier.dart';

class FirstPageInheritedNotifier extends InheritedNotifier<FirstPageNotifier> {
  const FirstPageInheritedNotifier({
    Key? key,
    required FirstPageNotifier notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static FirstPageNotifier watchNotifier(BuildContext context) {
    var inheritedNotifier = context
        .dependOnInheritedWidgetOfExactType<FirstPageInheritedNotifier>();
    assert(inheritedNotifier != null,
        'InheritedNotifier not found in the watchNotifier method');
    return inheritedNotifier!.notifier!;
  }

  static FirstPageNotifier readNotifier(BuildContext context) {
    var inheritedNotifier = context
        .getElementForInheritedWidgetOfExactType<FirstPageInheritedNotifier>();
    assert(inheritedNotifier != null,
        'InheritedNotifier not found in the readNotifier method');
    return (inheritedNotifier!.widget as FirstPageInheritedNotifier).notifier!;
  }
}

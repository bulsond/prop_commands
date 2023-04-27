import 'package:flutter/material.dart';

import 'second_page_notifier.dart';

class SecondPageInheritedNotifier
    extends InheritedNotifier<SecondPageNotifier> {
  const SecondPageInheritedNotifier({
    Key? key,
    required SecondPageNotifier notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static SecondPageNotifier watchNotifier(BuildContext context) {
    var inheritedNotifier = context
        .dependOnInheritedWidgetOfExactType<SecondPageInheritedNotifier>();
    assert(inheritedNotifier != null,
        'InheritedNotifier not found in the watchNotifier method');
    return inheritedNotifier!.notifier!;
  }

  static SecondPageNotifier readNotifier(BuildContext context) {
    var inheritedNotifier = context
        .getElementForInheritedWidgetOfExactType<SecondPageInheritedNotifier>();
    assert(inheritedNotifier != null,
        'InheritedNotifier not found in the readNotifier method');
    return (inheritedNotifier!.widget as SecondPageInheritedNotifier).notifier!;
  }
}

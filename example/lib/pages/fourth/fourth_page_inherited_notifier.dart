import 'package:flutter/material.dart';

import 'fourth_page_notifier.dart';

class FourthPageInheritedNotifier
    extends InheritedNotifier<FourthPageNotifier> {
  const FourthPageInheritedNotifier({
    Key? key,
    required FourthPageNotifier notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static FourthPageNotifier watchNotifier(BuildContext context) {
    var inheritedNotifier = context
        .dependOnInheritedWidgetOfExactType<FourthPageInheritedNotifier>();
    assert(inheritedNotifier != null,
        'InheritedNotifier not found in the watchNotifier method');
    return inheritedNotifier!.notifier!;
  }

  static FourthPageNotifier readNotifier(BuildContext context) {
    var inheritedNotifier = context
        .getElementForInheritedWidgetOfExactType<FourthPageInheritedNotifier>();
    assert(inheritedNotifier != null,
        'InheritedNotifier not found in the readNotifier method');
    return (inheritedNotifier!.widget as FourthPageInheritedNotifier).notifier!;
  }
}

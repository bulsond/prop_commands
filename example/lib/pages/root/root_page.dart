import 'package:flutter/material.dart';

import '../first/first_page.dart';
import '../first/first_page_inherited_notifier.dart';
import '../first/first_page_notifier.dart';
import '../second/second_page.dart';
import '../second/second_page_inherited_notifier.dart';
import '../second/second_page_notifier.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = FirstPageInheritedNotifier(
          notifier: FirstPageNotifier(),
          child: const FirstPage(),
        );
        break;
      case 1:
        page = SecondPageInheritedNotifier(
          notifier: SecondPageNotifier(),
          child: const SecondPage(),
        );
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.offline_bolt),
                    label: Text('First'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.group_work),
                    label: Text('Second'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';

import '../first/first_page.dart';
import '../first/first_page_inherited_notifier.dart';
import '../first/first_page_notifier.dart';
import '../fourth/data/person_db.dart';
import '../fourth/fourth_page.dart';
import '../fourth/fourth_page_inherited_notifier.dart';
import '../fourth/fourth_page_notifier.dart';
import '../second/second_page.dart';
import '../second/second_page_inherited_notifier.dart';
import '../second/second_page_notifier.dart';
import '../third/third_page.dart';
import '../third/third_page_inherited_notifier.dart';
import '../third/third_page_notifier.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var selectedIndex = 0;
  final personDb = PersonDb();

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
      case 2:
        page = ThirdPageInheritedNotifier(
          notifier: ThirdPageNotifier(),
          child: const ThirdPage(),
        );
        break;
      case 3:
        page = FourthPageInheritedNotifier(
          notifier: FourthPageNotifier(personDb: personDb),
          child: const FourthPage(),
        );
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              extended: constraints.maxWidth >= 600,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(
                    Icons.offline_bolt,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text(
                    '#1',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.group_work,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text(
                    '#2',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text(
                    '#3',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.pending,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text(
                    '#4',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'first_page_inherited_notifier.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final output =
        FirstPageInheritedNotifier.watchNotifier(context).outputProperty.value;
    final incrementCommand =
        FirstPageInheritedNotifier.readNotifier(context).incrementCommand;
    final decrementCommand =
        FirstPageInheritedNotifier.readNotifier(context).decrementCommand;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            output.toString(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: decrementCommand.canExecute()
                    ? decrementCommand.execute
                    : null,
                child: Icon(Icons.exposure_minus_1),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: incrementCommand.canExecute()
                    ? incrementCommand.execute
                    : null,
                child: Icon(Icons.plus_one),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: decrementCommand.canExecute()
                    ? decrementCommand.execute
                    : null,
                child: const Icon(Icons.exposure_minus_1),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: incrementCommand.canExecute()
                    ? incrementCommand.execute
                    : null,
                child: const Icon(Icons.plus_one),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

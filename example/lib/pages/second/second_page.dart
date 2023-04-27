import 'package:flutter/material.dart';

import 'second_page_inherited_notifier.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final output =
        SecondPageInheritedNotifier.watchNotifier(context).outputProperty.value;
    final command =
        SecondPageInheritedNotifier.readNotifier(context).changeCommand;

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
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () => command(-1),
                    child: Text(
                      '-1',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => command(-2),
                    child: Text(
                      '-2',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => command(-3),
                    child: Text(
                      '-3',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () => command(1),
                    child: Text(
                      '+1',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => command(2),
                    child: Text(
                      '+2',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => command(3),
                    child: Text(
                      '+3',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

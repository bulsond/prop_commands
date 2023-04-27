import 'package:flutter/material.dart';

import 'fourth_page_inherited_notifier.dart';
import 'widget/compose_widget.dart';
import 'widget/people_listview_widget.dart';

class FourthPage extends StatelessWidget {
  const FourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loadData =
        FourthPageInheritedNotifier.readNotifier(context).loadPeople;

    return Center(
      child: FutureBuilder<bool>(
        future: loadData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                return Column(
                  children: const [
                    ComposeWidget(),
                    SizedBox(height: 20),
                    PeopleListViewWidget(),
                  ],
                );
              } else {
                return const Text('No data');
              }
          }
        },
      ),
    );
  }
}

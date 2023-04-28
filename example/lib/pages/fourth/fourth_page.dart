import 'package:flutter/material.dart';

import 'fourth_page_inherited_notifier.dart';
import 'widget/compose_widget.dart';
import 'widget/people_listview_widget.dart';

class FourthPage extends StatefulWidget {
  const FourthPage({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

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
                  children: [
                    ComposeWidget(
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                    ),
                    const SizedBox(height: 20),
                    PeopleListViewWidget(
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                    ),
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

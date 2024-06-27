import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sustainable_footprint/src/screens/footprint_view.dart';
import 'package:sustainable_footprint/src/screens/holding_screen.dart';
import 'quiz_view.dart';
import '../obj/nav_item.dart';
import 'questionaire_view.dart';
import 'results_view.dart';

import '../settings/settings_view.dart';

/// Displays a list of SampleItems.
class NavListView extends StatelessWidget {
  const NavListView({
    super.key,
    this.items = const [
      NavItem("Quiz", QuizView.routeName,
          AssetImage('assets/images/flutter_logo.png')),
      NavItem("Questionaire", QuestionView.routeName,
          AssetImage('assets/images/flutter_logo.png')),
      NavItem("Results", ResultsView.routeName,
          AssetImage('assets/images/flutter_logo.png')),
      NavItem("Footprint Calculator", FootprintView.routeName,
          AssetImage('assets/images/flutter_logo.png')),
      NavItem("START QUIZ", HoldingView.routeName,
          AssetImage('assets/images/flutter_logo.png'))
    ],
  });

  static const routeName = '/';

  final List<NavItem> items;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        restorationId: 'navListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return ListTile(
              title: Text(item.id),
              leading: CircleAvatar(
                // Display the Flutter Logo image asset.
                foregroundImage: item.icon,
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(
                  context,
                  item.page,
                );
              });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class ResultsView extends StatelessWidget {
  const ResultsView({super.key});

  static const routeName = '/results';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('This is a results'),
      ),
    );
  }
}

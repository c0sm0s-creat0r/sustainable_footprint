import 'package:flutter/material.dart';
import 'package:sustainable_footprint/src/screens/quiz_view.dart';

/// Displays detailed information about a SampleItem.
class HoldingView extends StatelessWidget {
  const HoldingView({super.key});

  static const routeName = '/holding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          style:
              TextButton.styleFrom(elevation: 2, backgroundColor: Colors.white),
          onPressed: () {
            Navigator.restorablePushNamed(context, QuizView.routeName);
          },
          child: const Padding(
            padding: EdgeInsets.all(13.0),
            child: Text(
              "Start Quiz",
              style: TextStyle(fontSize: 35, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

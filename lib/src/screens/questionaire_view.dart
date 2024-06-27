import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/services.dart';

import 'package:sustainable_footprint/packages/flutter_survey.dart';
import 'dart:convert';

/// Displays detailed information about a SampleItem.
class QuestionView extends StatefulWidget {
  const QuestionView({super.key, this.count = -98});

  final int count;
  static const routeName = '/questions';

  @override
  State<QuestionView> createState() => _QuestionState();
}

class _QuestionState extends State<QuestionView> {
  final _formKey = GlobalKey<FormState>();
  List<QuestionResult> _questionResults = [];
  final List<Question> _initialData = [
    Question(
      question: 'What country are you from?',
    ),
    Question(
        question:
            "Consider the city of 'Toronto, Canada' what key words come to mind as part of this city's identity?"),
    Question(
        question:
            "Consider the city of 'Sydney, Australia' what key words come to mind as part of this city's identity?"),
    Question(
      question: 'What is your most common mode of transport?',
      answerChoices: {
        "Bike": [
          Question(
              question:
                  'How often do you bike compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
        "Car": [
          Question(
              question:
                  'How often do you drive compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
        "Tram": [
          Question(
              question:
                  'How often do you take the tram compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
        "Train": [
          Question(
              question:
                  'How often do you take the train compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
        "Bus": [
          Question(
              question:
                  'How often do you take the bus compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
        "Walking": [
          Question(
              question:
                  'How often do you walk compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
        "Other": [
          Question(question: 'Specify the mode of transport:'),
          Question(
              question:
                  'How often do you take this mode of transport compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
      },
    ),
    Question(
      question: 'What is your second most common mode of transport?',
      answerChoices: {
        "Bike": [
          Question(
              question:
                  'How often do you bike compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
        "Car": [
          Question(
              question:
                  'How often do you drive compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
        "Train": [
          Question(
              question:
                  'How often do you take the train compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
        "Bus": [
          Question(
              question:
                  'How often do you take the bus compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
        "Walking": [
          Question(
              question:
                  'How often do you walk compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
        "Other": [
          Question(question: 'Specify the mode of transport:'),
          Question(
              question:
                  'How often do you take this mode of transport compared to other modes of transport?',
              answerChoices: const {
                "It's my only mode of transport": null,
                "Most common": null,
                "Slightly more than others": null,
                "About even to other modes": null
              })
        ],
      },
    ),
    Question(
        question: 'How long have these been your preferred modes of transport?',
        answerChoices: const {
          "More than 10 years": null,
          "5-10 years": null,
          "3-5 years": null,
          "1-2 years": null,
          "6 months": null,
          "less than 3 months": null
        }),
    Question(
      question:
          'To what extend do you think the average Toronto citizen uses public transport?',
      answerChoices: const {
        "Often": null,
        "Sometimes": null,
        "Uncommonly": null,
        "Never": null,
      },
    ),
    Question(
      question: "What do you think is Toronto's most used transport option?",
      answerChoices: {
        "Car": null,
        "Tram": null,
        "Bike": null,
        "Walking": null,
        "Train": null,
        "Other": [Question(question: "Specify the mode of transport")],
      },
    ),
    Question(
      question:
          "What do you think is Toronto's second most used transport option?",
      answerChoices: {
        "Car": null,
        "Tram": null,
        "Bike": null,
        "Walking": null,
        "Train": null,
        "Other": [Question(question: "Specify the mode of transport")],
      },
    ),
    Question(
      question:
          'To what extend do you think the average Sydney, Australia citizen uses public transport?',
      answerChoices: const {
        "Often": null,
        "Sometimes": null,
        "Uncommonly": null,
        "Never": null,
      },
    ),
    Question(
      question: "What do you think is Sydney's most used transport option?",
      answerChoices: const {
        "Car": null,
        "Tram": null,
        "Bike": null,
        "Walking": null,
        "Train": null,
        "Other": null,
      },
    ),
    Question(
      question:
          "What do you think is Sydney's second most used transport option?",
      answerChoices: const {
        "Car": null,
        "Tram": null,
        "Bike": null,
        "Walking": null,
        "Train": null,
        "Other": null,
      },
    ),
    Question(
      question: "What is your age?",
      answerChoices: const {
        "Less than 18": null,
        "18-25": null,
        "26-35": null,
        "36-45": null,
        "46-55": null,
        "56-65": null,
        "65+": null,
      },
    ),
    Question(
      question: "What is your gender identity?",
      answerChoices: const {
        "Male": null,
        "Female": null,
        "Non-binary": null,
        "Other": null,
        "Prefer not to say": null,
      },
    ),
    Question(
      question: "Under what income bracket do you fall?",
      answerChoices: const {
        "<\$100,000": null,
        "\$100,001 - \$200,000": null,
        "\$200,000 - \$350,000": null,
        "\$350,000+": null,
      },
    ),
    Question(
      question: "What are your top three daily activities?",
    ),
  ];

  /*
What is your age?
What is your chosen gender identity?
Under what income bracket do you fall?
What are your top three personal activities?
What are your top three daily activities?


  */

  Map<String, String> returnResults(List<QuestionResult> questions) {
    Map<String, String> output = {};
    for (int i = 0; i < questions.length; i++) {
      print("${questions[i].question} ${questions[i].answers}");
      output[questions[i].question] = questions[i].answers.join(', ');
      if (questions[i].children.isNotEmpty) {
        output.addEntries(returnResults(questions[i].children).entries);
      }
    }
    print(output);
    return output;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference db =
        FirebaseFirestore.instance.collection("toronto-results");
    return Scaffold(
      appBar: AppBar(
        title: Text("Sustainable count: ${widget.count}"),
      ),
      body: Form(
        key: _formKey,
        child: Survey(
          onNext: (questionResults) {
            _questionResults = questionResults;
          },
          initialData: _initialData,
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.blueGrey, // Background Color
              ),
              child: const Text("Submit"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  db.add(returnResults(_questionResults));
                  // returnResults(_questionResults);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

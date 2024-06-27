import 'package:flutter/material.dart';
import 'package:sustainable_footprint/src/obj/photo_pair.dart';
import 'package:sustainable_footprint/src/screens/questionaire_view.dart';

/// Displays detailed information about a SampleItem.
class QuizView extends StatefulWidget {
  const QuizView({super.key});

  static const routeName = '/quiz';

  @override
  State<QuizView> createState() => _QuizState();
}

class _QuizState extends State<QuizView> {
  // List<String> cardList = ["Card 1", "Card 2", "Card 3", "Card 4", "Card 5"];
  List<PhotoPair> cardList = [
    const PhotoPair(
      AssetImage('assets/images/1_1.jpg'),
      AssetImage('assets/images/1_2.jpg'),
      0,
      1,
      "1",
    ),
    const PhotoPair(
      AssetImage('assets/images/2_1.jpg'),
      AssetImage('assets/images/2_2.jpg'),
      1,
      -1,
      "2",
    ),
    const PhotoPair(
      AssetImage('assets/images/3_1.jpg'),
      AssetImage('assets/images/3_2.jpg'),
      0,
      0,
      "3",
    ),
    const PhotoPair(
      AssetImage('assets/images/4_1.jpg'),
      AssetImage('assets/images/4_2.jpg'),
      0,
      1,
      "4",
    ),
    const PhotoPair(
      AssetImage('assets/images/5_1.jpg'),
      AssetImage('assets/images/5_2.jpg'),
      1,
      -1,
      "5",
    ),
    const PhotoPair(
      AssetImage('assets/images/6_1.jpg'),
      AssetImage('assets/images/6_2.jpg'),
      1,
      -1,
      "6",
    ),
    const PhotoPair(
      AssetImage('assets/images/7_1.jpg'),
      AssetImage('assets/images/7_2.jpg'),
      0,
      0,
      "7",
    ),
    const PhotoPair(
      AssetImage('assets/images/8_1.jpg'),
      AssetImage('assets/images/8_2.jpg'),
      1,
      -1,
      "8",
    )
  ];

  int sustainableCount = 0;

  void handleNextPair(int index, int photoValue) {
    setState(() {
      cardList.removeAt(index);
    });
    sustainableCount += photoValue;
    if (cardList.isEmpty) {
      Navigator.restorablePopAndPushNamed(
        context,
        QuestionView.routeName,
        arguments: sustainableCount,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double photoWidth = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: TextStyle(
              fontSize: 18,
            ),
            children: <TextSpan>[
              TextSpan(text: 'Which photo captures the essence of its city?'),
              TextSpan(text: '', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ''),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text(
            //   "* Identity as in the ideas",
            //   style: TextStyle(fontSize: 20, color: Colors.grey),
            // ),
            // SizedBox(height: 30),
            SizedBox(
              height: MediaQuery.of(context).size.height * .75,
              child: Stack(
                children: cardList.map((card) {
                  int index = cardList.indexOf(card);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          handleNextPair(index, card.photo1value);
                        },
                        child: Dismissible(
                          key: const Key("1"),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            handleNextPair(index, card.photo1value);
                          },
                          child: Card(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10.0),
                              width: photoWidth,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: card.photo1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          handleNextPair(index, card.photo2value);
                        },
                        child: Dismissible(
                          key: const Key("2"),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            handleNextPair(index, card.photo2value);
                          },
                          child: Card(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10.0),
                              width: photoWidth,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: card.photo2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  Text("Swipe towards or tap your choice"),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

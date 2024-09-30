import 'package:course_compass/pages/course_list_page.dart';
import 'package:course_compass/shared/base_appbar.dart';
import 'package:flutter/material.dart';

class CourseCompassHomePage extends StatefulWidget {
  const CourseCompassHomePage({super.key});

  @override
  State<CourseCompassHomePage> createState() => _CourseCompassHomePageState();
}

class _CourseCompassHomePageState extends State<CourseCompassHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: appBar,
      body: const Center(
        child: CourseCompassCardView(),
      ),
    );
  }
}

class CourseCompassCardView extends StatefulWidget {
  const CourseCompassCardView({super.key});

  @override
  State<CourseCompassCardView> createState() => _CourseCompassCardViewState();
}

class _CourseCompassCardViewState extends State<CourseCompassCardView> {
  bool page1 = true;
  @override
  Widget build(BuildContext context) {
    return const CardPreferenceContent();
  }
}

class CardPreferenceContent extends StatefulWidget {
  const CardPreferenceContent({
    super.key,
  });

  @override
  State<CardPreferenceContent> createState() => _CardPreferenceContentState();
}

class _CardPreferenceContentState extends State<CardPreferenceContent> {
  bool changePage = false;
  bool nextButtonVisible = false;
  bool buttonVisibile = true;
  List<String> preferences = ["Writing", "Cooking", "Tech"];
  String headerMessage = "What are you interested in?";
  List<String> userPreferences = [];
  final TextEditingController _textEditingController = TextEditingController();
  late String userLocation;

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;
    Widget headerText = Padding(
      padding: const EdgeInsets.only(
        top: 25,
      ),
      child: Text(
        headerMessage,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    return SizedBox(
      height: screenH * .6,
      width: screenW * .5,
      child: Card(
        color: Colors.blueGrey[500],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        shadowColor: Colors.red[200],
        elevation: 15,
        child: Column(
          children: [
            headerText,
            SizedBox(
              height: screenH * .05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    onSubmitted: (value) {
                      setState(() {
                        userLocation = value;
                      });
                    },
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenH * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: preferences.map(
                    (preference) {
                      return TextButton(
                        onPressed: buttonVisibile
                            ? () {
                                setState(() {
                                  userPreferences.add(preference);
                                  headerMessage = "Describe your self";
                                  preferences = ['Introvert', 'Extrovert'];
                                });
                                if (preferences[0] == "Introvert" &&
                                    preferences[1] == "Extrovert") {
                                  if (userPreferences.length == 2) {
                                    setState(() {
                                      nextButtonVisible = true;
                                      buttonVisibile = false;
                                    });
                                  }
                                }
                              }
                            : () {},
                        child: Text(
                          preference,
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ).toList(),
                ),
                SizedBox(
                  height: screenH * .15,
                ),
                nextButtonVisible
                    ? ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseListView(
                              userPreference: userPreferences,
                              location: userLocation,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Next",
                        ),
                      )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

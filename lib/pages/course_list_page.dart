import 'package:course_compass/shared/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class CourseListView extends StatefulWidget {
  final List<String> userPreference;
  final String location;
  const CourseListView(
      {super.key, required this.userPreference, required this.location});

  @override
  State<CourseListView> createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {
  final model = GenerativeModel(
    model: "gemini-1.5-flash",
    apiKey: "AIzaSyCx57_g90Y_bEe0vR76-GPAObI5GSAPYtw",
    generationConfig: GenerationConfig(
      temperature: 2,
      topK: 64,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'application/json',
    ),
    systemInstruction: Content.system(
        'you are tasked to act as a course tracker where users will give you informations about them such as their interest and about themselves whether they are Introvert or Extrovert. you will provide them all courses that fits them based on the interests and whether they are introvert or extrovert. users will provide you with their location and you have to identify what are the nearest college on their location that offer the courses that best fits them based on their inputs. the users will provide you with single word inputs such as their interest (Cooking, Writing, Tech) and their personality (Introvert or Extrovert) in a form of list (example, [Tech, Introvert]). the format of your response should be, course_name, college, address, tuition_fee.'),
  );
  late ChatSession chat;

  @override
  void initState() {
    super.initState();
    chat = model.startChat(history: []);
  }

  Future<GenerateContentResponse> _fetchResponse() async {
    String input = "${widget.userPreference} location is ${widget.location}";
    final content = Content.text(input);
    return await chat.sendMessage(content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: _fetchResponse(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Text(snapshot.data!.text!);
        },
      ),
    );
  }
}

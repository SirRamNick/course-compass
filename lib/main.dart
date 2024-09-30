import 'package:course_compass/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Course Compass",
      home: const CourseCompassHomePage(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.transparent,
          titleTextStyle: TextStyle(
            fontSize: 60,
            fontStyle: FontStyle.italic,
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 60,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            fontSize: 25,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: const WidgetStatePropertyAll(Colors.black),
            backgroundColor: const WidgetStatePropertyAll(Colors.white38),
            elevation: const WidgetStatePropertyAll(5),
            shadowColor: WidgetStatePropertyAll(
              Colors.red[200],
            ),
          ),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Colors.black54,
            ),
            foregroundColor: WidgetStatePropertyAll(
              Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

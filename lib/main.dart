import 'package:flutter/material.dart';
import 'package:joyful/form_task.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JOYFUL',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
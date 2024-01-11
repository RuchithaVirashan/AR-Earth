import 'package:ar_project/Screen/about.dart';
import 'package:ar_project/Screen/home.dart';
import 'package:ar_project/Screen/onbording.dart';
import 'package:ar_project/Screen/podcast.dart';
import 'package:flutter/material.dart';

import 'Screen/earth.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const OnbordingScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/earth': (context) => EarthScreen(),
        '/landing': (context) => HomeScreen(),
        '/about': (context) => AboutScreen(),
        '/podcast': (context) => ProdcastScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

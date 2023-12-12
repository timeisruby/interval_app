import 'package:flutter/material.dart';
import 'package:interval/screen/home_screen.dart';
import 'package:interval/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Interval",
      initialRoute: '/',
      routes: {
        '/':(context) => SplashScreen(),
        '/main':(context) => HomeScreen(),
      },
    );
  }
}
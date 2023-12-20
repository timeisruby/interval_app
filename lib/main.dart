import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:interval/hjkim/screens/home_screen.dart';
import 'package:interval/hjkim/provider/timer_provider.dart';
import 'package:interval/screen/splash_screen.dart';
import 'package:interval/swchoi/screen/Timer_screen.dart';

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
        '/': (context) => SplashScreen(),
        '/main': (context) => ChangeNotifierProvider<TimerProvider>(
              create: (context) => TimerProvider(),
              child: HomeScreen(),
            ),
        '/home':(context) => TimerScreen(),
      },
    );
  }
}

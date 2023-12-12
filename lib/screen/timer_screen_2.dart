import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

class TimerTwo extends StatefulWidget {
  const TimerTwo({super.key});

  @override
  State<TimerTwo> createState() => _TimerTwoState();
}

class _TimerTwoState extends State<TimerTwo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer App"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: Text("App Content"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:interval/swchoi/screen/Timer_widget.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent.shade100,
          title: Text("Interval Timer"),
        ),
        backgroundColor: Colors.red.shade100,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerWidget()
            ],
          ),
        ));
  }
}



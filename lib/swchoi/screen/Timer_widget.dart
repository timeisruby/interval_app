import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _seconds = 0;
  late Timer _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), _onTimerTick);
  }

  void _onTimerTick(Timer timer) {
    if (_isRunning) {
      setState(() {
        _seconds++;
      });
    }
  }

  void _startStopTimer() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String formatTimer = "$_seconds";
    return Column(
      children: [
        Container(
          child: Text(formatTimer,style: TextStyle(fontSize: 70),),
        ),
        Container(
          child: buildButton(_startStopTimer,_resetTimer,_isRunning)
        )
      ],
    );
  }
}


Widget buildButton(VoidCallback startStopCallback, VoidCallback resetCallback, bool isRunning){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      ElevatedButton(
        onPressed: startStopCallback,
        child: isRunning ? Text("Stop") : Text("Start"),
      ),
      SizedBox(width: 30),
      ElevatedButton(
        onPressed: resetCallback,
        child: Text("Reset"),
      ),
    ],
  );
}
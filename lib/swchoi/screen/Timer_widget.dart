import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _milliseconds = 0;
  late Timer _timer;
  bool _isRunning = false;
  List<String> labTimer = [];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1), _onTimerTick);
  }

  void _onTimerTick(Timer timer) {
    if (_isRunning) {
      setState(() {
        _milliseconds++;
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
      if (!_isRunning) {
        labTimer.clear();
      } else {
        labTimer.clear();
        _milliseconds = 0;
        _isRunning = false;
      }
    });
  }

  void _labTimer() {
    setState(() {
      labTimer.insert(0, formatTimer(_milliseconds));
    });
  }

  String formatTimer(int milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds);
    int seconds = duration.inSeconds % 60;
    int minutes = (duration.inMinutes % 60);
    int hours = duration.inHours;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    String _formatTimer = formatTimer(_milliseconds);
    return Column(
      children: [
        Container(
          child: Text(
            _formatTimer,
            style: TextStyle(fontSize: 70),
          ),
        ),
        Container(
            child: buildButton(
                _startStopTimer, _resetTimer, _labTimer, _isRunning)),
        SizedBox(height: 30),
        Container(
            height: 200,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: labTimer.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${labTimer[index]}"),
                );
              },
            ))
      ],
    );
  }
}

Widget buildButton(VoidCallback startStopCallback, VoidCallback resetCallback,
    VoidCallback labTimerCallback, bool isRunning) {
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
      SizedBox(width: 30),
      ElevatedButton(onPressed: labTimerCallback, child: Text("Lab"))
    ],
  );
}

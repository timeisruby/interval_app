import 'package:flutter/material.dart';
import 'package:interval/style/style.dart';
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
  final ScrollController _controller = ScrollController();
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1), _onTimerTick);
    _controller.addListener(_onScroll);
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

  void _onScroll() {
    if (!_controller.position.isScrollingNotifier.value) {
      setState(() {
        _isScrolling = true;
      });
    }
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
          child: Scrollbar(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: _controller,
              itemCount: labTimer.length,
              itemBuilder: (context, index) {
                Color itemColor = _isScrolling ? Colors.blue : Colors.red;
                return Container(
                  color: itemColor,
                  child: Text("${labTimer[index]}"),
                );
              },
            ),
          ),
        ),
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
        style: customButtonStyle.copyWith(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(Colors.black)),
        child: isRunning ? Text("Stop") : Text("Start"),
      ),
      SizedBox(width: 30),
      ElevatedButton(
        onPressed: resetCallback,
        style: customButtonStyle.copyWith(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
        child: Text("Reset"),
      ),
      SizedBox(width: 30),
      ElevatedButton(
        onPressed: labTimerCallback,
        style: customButtonStyle.copyWith(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(Colors.black)),
        child: Text("Lab"),
      )
    ],
  );
}

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
      labTimer.clear();
      _milliseconds = 0;
      _isRunning = false;
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
    int millisecond = duration.inMilliseconds % 1000 ~/ 10;
    int seconds = duration.inSeconds % 60;
    int minutes = (duration.inMinutes % 60);

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${millisecond.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    String _formatTimer = formatTimer(_milliseconds);
    return Column(
      children: [
        Container(
          child: Text(
            _formatTimer,
            style: TextStyle(fontSize: 70, color: Colors.white),
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.white, width: 1.0))),
            child: buildButton(
                _startStopTimer, _resetTimer, _labTimer, _isRunning)),
        Container(
          height: 200,
          child: Scrollbar(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: _controller,
              itemCount: labTimer.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.white, width: 1.0))),
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("랩 ${index + 1}",
                          style: TextStyle(fontSize: 25, color: Colors.white)),
                      Text("${labTimer[index]}",
                          style: TextStyle(fontSize: 25, color: Colors.white)),
                    ],
                  ),
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
  double buttonSize = 100.0; // 버튼 크기를 조절할 값
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      RawMaterialButton(
          onPressed: isRunning ? labTimerCallback : resetCallback,
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.grey.withOpacity(0.4),
          constraints:
              BoxConstraints.tightFor(width: buttonSize, height: buttonSize),
          child: isRunning
              ? Text("Lab", style: TextStyle(fontSize: 20, color: Colors.white))
              : Text("Reset",
                  style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.4)))),
      RawMaterialButton(
        onPressed: startStopCallback,
        shape: CircleBorder(),
        elevation: 2.0,
        fillColor: isRunning
            ? Colors.red.withOpacity(0.4)
            : Colors.green.withOpacity(0.4),
        constraints:
            BoxConstraints.tightFor(width: buttonSize, height: buttonSize),
        child: isRunning
            ? Text("Stop", style: TextStyle(fontSize: 20, color: Colors.red))
            : Text("Start",
                style: TextStyle(fontSize: 20, color: Colors.green)),
      ),
    ],
  );
}

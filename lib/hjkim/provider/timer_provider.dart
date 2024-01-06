import 'dart:async';

import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  late Timer _timer;
  int _hour = 0;
  int _minute = 0;
  int _seconds = 0;
  List<Map<String, int>> _labTimes = [];
  bool _startEnable = true;
  bool _stopEnable = false;
  bool _continueEnable = false;
  bool _labEnable = false;
  bool _resetEnable = false;
  int _labIndex = 1;

  int get hour => _hour;
  int get minute => _minute;
  int get seconds => _seconds;
  List<Map<String, int>> get labTimes => _labTimes;
  bool get startEnable => _startEnable;
  bool get stopEnable => _stopEnable;
  bool get continueEnable => _continueEnable;
  bool get labEnable => _labEnable;
  bool get resetEnable => _resetEnable;
  int get labIndex => _labIndex;

  void startTimer() {
    _hour = 0;
    _minute = 0;
    _seconds = 0;
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;
    _labEnable = true;
    _resetEnable = false;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds < 59) {
        _seconds++;
      } else if (_seconds == 59) {
        _seconds = 0;
        if (_minute == 59) {
          _hour++;
          _minute = 0;
        } else {
          _minute++;
        }
      }

      notifyListeners();
    });
  }

  void stopTimer() {
    if (_startEnable == false) {
      _startEnable = true;
      _continueEnable = true;
      _stopEnable = false;
      _labEnable = false;
      _resetEnable = true;
      _timer.cancel();
    }
    notifyListeners();
  }

  void continueTimer() {
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;
    _labEnable = true;
    _resetEnable = false;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds < 59) {
        _seconds++;
      } else if (_seconds == 59) {
        _seconds = 0;
        if (_minute == 59) {
          _hour++;
          _minute = 0;
        } else {
          _minute++;
        }
      }

      notifyListeners();
    });
  }

  void labTimer() {
    _labIndex++;
    int labHour = _hour;
    int labMinute = _minute;
    int labSeconds = _seconds;

    // 현재 Lab의 시간 값을 기록
    _labTimes
        .add({'hour': labHour, 'minute': labMinute, 'seconds': labSeconds});

    notifyListeners();
  }

  void resetTimer() {
    _labIndex = 1;
    _labTimes.clear();
    _resetEnable = false;
    notifyListeners();
  }

  set labIndex(int newIndex) {
    _labIndex = newIndex;
    notifyListeners();
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  late Timer _timer;
  int _hour = 0;
  int _minute = 0;
  int _seconds = 0;
  bool _startEnable = true;
  bool _stopEnable = false;
  bool _continueEnable = false;
  bool _labEnable = false;

  int get hour => _hour;

  int get minute => _minute;

  int get seconds => _seconds;

  bool get startEnable => _startEnable;

  bool get stopEnable => _stopEnable;

  bool get continueEnable => _continueEnable;

  bool get labEnable => _labEnable;

  void startTimer() {
    _hour = 0;
    _minute = 0;
    _seconds = 0;
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;
    _labEnable = true;

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
      _timer.cancel();
    }
    notifyListeners();
  }

  void continueTimer() {
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;
    _labEnable = true;

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

  void lapTimer() {
    if (_startEnable == false) {
      _startEnable = true;
      _continueEnable = true;
      _stopEnable = false;
      _labEnable = false;

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
  }

  void labTimer() {
    print('Lab Timer - Hour: $_hour, Minute: $_minute, Seconds: $_seconds');
  }
}
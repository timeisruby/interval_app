import 'package:flutter/material.dart';
import 'package:interval/swchoi/screen/Timer_widget.dart';

Widget StopwatchScreen() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [TimerWidget()],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:interval/swchoi/screen/Noti_screen.dart';
import 'package:interval/swchoi/screen/World_Timer_screen.dart';
import 'package:interval/swchoi/screen/page_screen.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: Colors.grey.shade900,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: textTheme.bodySmall,
          unselectedLabelStyle: textTheme.bodySmall,
          onTap: (value) {
            // Respond to item press.
            setState(() => _currentIndex = value);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "알람"),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_time), label: "스톱워치"),
            BottomNavigationBarItem(icon: Icon(Icons.language), label: "세계시간")
          ],
        ),
        backgroundColor: Colors.black,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            NotiScreen(),
            StopwatchScreen(),
            WorldTimeScreen(),
          ],
        ));
  }
}

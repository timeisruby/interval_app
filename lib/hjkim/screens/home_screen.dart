import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:interval/hjkim/provider/timer_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var timer;

  @override
  void initState() {
    super.initState();
    timer = Provider.of<TimerProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: homeScreenBody(),
    );
  }

  Widget homeScreenBody() {
    return Container(child: Consumer<TimerProvider>(
      builder: (context, timeprovider, widget) {
        return Column(children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              '${timer.hour} : ' + '${timer.minute} : ' + '${timer.seconds} ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              (timer.startEnable)
                  ? ElevatedButton(
                      onPressed: timer.startTimer,
                      child: Text('Start'),
                    )
                  : ElevatedButton(
                      onPressed: null,
                      child: Text('Start'),
                    ),
              (timer.stopEnable)
                  ? ElevatedButton(
                      onPressed: timer.stopTimer,
                      child: Text('Stop'),
                    )
                  : ElevatedButton(
                      onPressed: null,
                      child: Text('Stop'),
                    ),
              (timer.continueEnable)
                  ? ElevatedButton(
                      onPressed: timer.continueTimer,
                      child: Text('Continue'),
                    )
                  : ElevatedButton(
                      onPressed: null,
                      child: Text('Continue'),
                    ),
              (timer.labEnable)
                  ? ElevatedButton(
                      onPressed: (timer.labEnable)
                          ? timer.labTimer
                          : (timer.resetEnable)
                              ? timer.resetEnable
                              : null,
                      child: Text((timer.resetEnable) ? 'Reset' : 'Lab'),
                    )
                  : ElevatedButton(
                      onPressed: null,
                      child: Text('Lab'),
                    ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Text(
                '${timer.labHour} : ' +
                    '${timer.labMinute} : ' +
                    '${timer.labSeconds} ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ]);
      },
    ));
  }
}

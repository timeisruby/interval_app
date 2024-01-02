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

  void labButtonPressed() {
    // 다음 인덱스로 업데이트
    timer.labTimer();
    setState(() {});
  }

  void labButtonResetPressed() {
    // 다음 인덱스로 업데이트
    timer.resetEnable();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          homeScreenButton(timer),
          Expanded(
            child: ListView.builder(
              itemCount: timer.labIndex,
              itemBuilder: (context, index) {
                return labTimerIndexWithIndex(timer, index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget homeScreenButton(dynamic timer) {
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
              ElevatedButton(
                onPressed: (timer.labEnable)
                    ? () {
                        if (timer.labEnable) {
                          labButtonPressed();
                        } else if (timer.resetEnable) {
                          labButtonResetPressed();
                        }
                      }
                    : (timer.resetEnable)
                        ? () {
                            timer.resetTimer();
                          }
                        : null,
                child: Text((timer.resetEnable) ? 'Reset' : 'Lab'),
              ),
            ],
          ),
        ]);
      },
    ));
  }

  Widget labTimerIndexWithIndex(dynamic timer, int labIndex) {
    return Container(
      child: Consumer<TimerProvider>(
        builder: (context, timeprovider, widget) {
          // 여기서 변경
          if (labIndex <= timer.labTimes.length) {
            final labTime = timer.labTimes[labIndex - 1];
            return Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Lab $labIndex: ${labTime['hour']} : ${labTime['minute']} : ${labTime['seconds']}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            );
          } else {
            // 인덱스가 범위를 벗어나는 경우 처리
            return Container();
          }
        },
      ),
    );
  }
}

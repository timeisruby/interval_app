import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class ClockApp extends StatefulWidget {
  const ClockApp({super.key});

  @override
  State<ClockApp> createState() => _ClockAppState();
}

class _ClockAppState extends State<ClockApp> {
  String? time; // late String -> String? Nullable
  late Timer _timer;
  int count = 0;
  String? selectFormat;
  bool isChangeFormat = false;

  int? intervalTime;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isChangeFormat) {
        setState(() {
          if (selectFormat == null) {
            time = DateFormat("HH:mm:ss").format(DateTime.now());
          } else {
            time = DateFormat(selectFormat).format(DateTime.now());
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _showFormat() async {
    setState(() {
      isChangeFormat = true;
    });

    selectFormat = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("시간 형식 선택"),
          content: Column(
            children: [
              _selectFormatWiget('HH:mm:ss'),
              _selectFormatWiget("ss")
            ],
          ),
        );
      },
    );

    setState(() {
      isChangeFormat = false;
    });
  }

  Widget _selectFormatWiget(String format) {
    return ListTile(
      title: Text(format),
      subtitle: Text("TEST"),
      tileColor: format == selectFormat ? Colors.blue : null,
      trailing: Icon(Icons.arrow_back),
      onTap: () {
        setState(() {
          selectFormat = format;
        });
        Navigator.pop(context, selectFormat);
      },
    );
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: _showFormat,
              icon: Icon(
                Icons.settings,
                size: 40,
              ),
            )
          ],
          bottom: TabBar(
            tabs: [Tab(text: "Clock"), Tab(text: "Interval")],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (time == null || isChangeFormat)
                    CircularProgressIndicator()
                  else
                    Text(
                      time!,
                      style: TextStyle(color: Colors.black, fontSize: 100),
                    ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Interval",
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(height: 20),
                  Text('인터벌 설정 (초):'),
                  SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        intervalTime = int.tryParse(value) ?? 0;
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            intervalTime = 0;
          },
          tooltip: "타이머 재설정",
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}

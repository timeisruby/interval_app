import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldTimeScreen extends StatefulWidget {
  const WorldTimeScreen({super.key});

  @override
  State<WorldTimeScreen> createState() => _WorldTimeScreenState();
}

class _WorldTimeScreenState extends State<WorldTimeScreen> {
  late String _selectedLocation;
  late String _worldTime;

  void initState() {
    super.initState();
    _selectedLocation = 'Asia/Seoul'; // 초기값은 서울로 설정
    _loadWorldTime();
  }

  Future<void> _loadWorldTime() async {
    try {
      final response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/$_selectedLocation'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final dateTime = DateTime.parse(data['utc_datetime']);
        setState(() {
          _worldTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
        });
      } else {
        throw Exception('Failed to load world time');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: _selectedLocation,
            onChanged: (String? newValue) {
              setState(() {
                _selectedLocation = newValue!;
                _loadWorldTime();
              });
            },
            items: ['Asia/Seoul', 'America/New_York']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
            dropdownColor: Colors.orangeAccent.shade400,
          ),
          SizedBox(height: 20),
          _worldTime != ""
              ? Text(
                  '$_selectedLocation : $_worldTime',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
              : CircularProgressIndicator(),
        ],
      ),
    );
  }
}

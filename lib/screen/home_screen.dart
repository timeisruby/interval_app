import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "원하는 버전을 선택하세요",
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VersionButton(context, "/hj", "HJ", Colors.blue),
                SizedBox(width: 30,),
                VersionButton(context, "/sw", "SW", Colors.red)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget VersionButton(
    BuildContext context, String route, String label, Color backColor) {
  return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 50),
      ));
}

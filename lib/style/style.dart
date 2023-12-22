import 'package:flutter/material.dart';

final customButtonStyle = ElevatedButton.styleFrom(
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // 버튼 내부 패딩
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
);
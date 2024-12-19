import 'package:flutter/material.dart';
import '../colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Home', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(
          'Welcome to Pet Care!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
        ),
      ),
    );
  }
}

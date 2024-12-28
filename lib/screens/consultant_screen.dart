import 'package:flutter/material.dart';
import '../colors.dart';

class ConsultantScreen extends StatelessWidget {
  const ConsultantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Consultant Service', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(
          'Book a free consultation!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: secondaryColor),
        ),
      ),
    );
  }
}

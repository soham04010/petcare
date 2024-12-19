import 'package:flutter/material.dart';
import '../colors.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('My Account', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(
          'Manage your account here.',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
        ),
      ),
    );
  }
}

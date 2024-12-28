import 'package:flutter/material.dart';
import '../colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Products', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(
          'Browse our Products!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: secondaryColor),
        ),
      ),
    );
  }
}

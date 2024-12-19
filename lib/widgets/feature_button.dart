import 'package:flutter/material.dart';

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const FeatureButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 30, color: Colors.orange),
        ),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}

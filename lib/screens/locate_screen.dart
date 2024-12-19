import 'package:flutter/material.dart';

class LocateScreen extends StatelessWidget {
  const LocateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Nearby Vet Shops, Pet Care, and Pharmacies within 5Km',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

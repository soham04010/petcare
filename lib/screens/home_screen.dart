import 'package:flutter/material.dart';
import '../colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Pet Care',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'For Location...',
                prefixIcon: Icon(Icons.search, color: secondaryColor),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Grid of Features
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: [
                  // Pet Health
                  _buildFeatureCard(
                    icon: Icons.favorite,
                    label: 'Pet Health',
                    color: Colors.redAccent,
                  ),
                  // Calendar
                  _buildFeatureCard(
                    icon: Icons.calendar_today,
                    label: 'Calendar',
                    color: Colors.blueAccent,
                  ),
                  // Products
                  _buildFeatureCard(
                    icon: Icons.shopping_bag,
                    label: 'Products',
                    color: Colors.orangeAccent,
                  ),
                  // Account
                  _buildFeatureCard(
                    icon: Icons.account_circle,
                    label: 'Account',
                    color: Colors.greenAccent,
                  ),
                  // Consultant
                  _buildFeatureCard(
                    icon: Icons.support_agent,
                    label: 'Consultant',
                    color: Colors.purpleAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build feature cards
  Widget _buildFeatureCard({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () {
          // Handle navigation or actions here
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

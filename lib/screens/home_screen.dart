import 'package:flutter/material.dart';
//import '../colors.dart';
import './discover.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text(
          'Pet Care ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Promotional Banner
              _buildPromotionalBanner(context),

              // Services Section
              SizedBox(height: 20),
              _buildSectionHeader('Services', () {}),
              _buildServiceGrid(),

              // Veterinarian Section
              SizedBox(height: 20),
              _buildSectionHeader('Our Best Veterinarian', () {}),
              _buildVeterinarianProfile(),
            ],
          ),
        ),
      ),
    );
  }

  // Promotional Banner Widget (Empty Image Placeholder)
 // Promotional Banner Widget (Empty Image Placeholder)
Widget _buildPromotionalBanner(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 20, bottom: 20),
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: const Color.fromARGB(255, 255, 155, 55),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Discover Top Vet Doctors \nin Your Area!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Discover()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orangeAccent,
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Discover'),
            ),
          ],
        ),
      ),
    ),
  );
}


  // Services Section Header Widget
  Widget _buildSectionHeader(String title, VoidCallback onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text('See All', style: TextStyle(color: Colors.orangeAccent)),
        ),
      ],
    );
  }

  // Service Grid Widget
  Widget _buildServiceGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics:
          NeverScrollableScrollPhysics(), // Prevents GridView from interfering with scrolling
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _serviceCard('Vaccinations'),
        _serviceCard('Grooming'),
        _serviceCard('Walking'),
        _serviceCard('Training'),
      ],
    );
  }

  // Service Card Widget (Empty Placeholder)
  Widget _serviceCard(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pets, size: 40, color: Colors.orange), // Temporary Icon
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Veterinarian Profile Widget (Empty Placeholder)
  Widget _buildVeterinarianProfile() {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[300], // Empty placeholder
        child: Icon(Icons.person, size: 30, color: Colors.white),
      ),
      title: Text(
        'Cameron Williamson',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Row(
        children: [
          Text('Veterinary Behavioral',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(width: 8),
          Icon(Icons.star, color: Colors.orange, size: 16),
          Text('4.5', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

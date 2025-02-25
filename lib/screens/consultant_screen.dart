import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

class ConsultantScreen extends StatelessWidget {
  // List of consultants
  final List<Map<String, String>> consultants = [
    {
      "name": "Dr. Ramesh Kumar",
      "mobile": "9876543210",
      "experience": "10 years",
      "specialization": "Veterinary Medicine"
    },
    {
      "name": "Dr. Anjali Mehta",
      "mobile": "9123456789",
      "experience": "8 years",
      "specialization": "Animal Nutrition"
    },
    {
      "name": "Dr. Ravi Patel",
      "mobile": "8899001122",
      "experience": "5 years",
      "specialization": "Pet Surgery"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultants'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: consultants.length,
        itemBuilder: (context, index) {
          final consultant = consultants[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                consultant['name'] ?? '',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                'Experience: ${consultant['experience']}\nSpecialization: ${consultant['specialization']}',
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to consultant details page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsultantDetailsScreen(
                      name: consultant['name'] ?? '',
                      mobile: consultant['mobile'] ?? '',
                      experience: consultant['experience'] ?? '',
                      specialization: consultant['specialization'] ?? '',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ConsultantDetailsScreen extends StatelessWidget {
  final String name;
  final String mobile;
  final String experience;
  final String specialization;

  ConsultantDetailsScreen({
    required this.name,
    required this.mobile,
    required this.experience,
    required this.specialization,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultant Details'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 8),
            Text(
              'Experience: $experience',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Specialization: $specialization',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _makeCall(mobile);
                  },
                  icon: Icon(Icons.call),
                  label: Text('Call'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _sendMessage(mobile);
                  },
                  icon: Icon(Icons.message),
                  label: Text('Message'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to make a call
  void _makeCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  // Function to send a message
  void _sendMessage(String phoneNumber) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}

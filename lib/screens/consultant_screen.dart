import 'package:flutter/material.dart';
import 'package:pet_care_finder/services/consultant_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultantScreen extends StatefulWidget {
  @override
  _ConsultantScreenState createState() => _ConsultantScreenState();
}

class _ConsultantScreenState extends State<ConsultantScreen> {
  List<dynamic>? consultants;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadConsultants();
  }

  // Fetch consultants from API
  void loadConsultants() async {
    try {
      var data = await ConsultantService().fetchConsultants();

      setState(() {
        consultants = data;
        isLoading = false;
      });

      print("✅ Consultants Loaded: ${consultants!.length}"); // Debug log
    } catch (e) {
      print('❌ Error fetching consultants: $e');
      setState(() {
        consultants = [];
        isLoading = false;
      });
    }
  }

  // Book a consultant
  void bookConsultant(String id) async {
    bool success = await ConsultantService().bookConsultant(id);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Consultant booked successfully!")),
      );
      loadConsultants(); // Refresh list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed to book consultant. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consultants'), backgroundColor: Colors.orange),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : (consultants == null || consultants!.isEmpty)
              ? Center(child: Text("⚠ No consultants available."))
              : ListView.builder(
                  itemCount: consultants!.length,
                  itemBuilder: (context, index) {
                    var consultant = consultants![index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(
                          consultant['name'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(
                          'Experience: ${consultant['experience']} years\nSpecialization: ${consultant['specialization']}',
                        ),
                        trailing: ElevatedButton(
                          onPressed: () => bookConsultant(consultant['_id']),
                          child: Text("Book"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        ),
                        onTap: () {
                          // Navigate to consultant details page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConsultantDetailsScreen(
                                id: consultant['_id'],
                                name: consultant['name'],
                                mobile: consultant['phone'],
                                experience: consultant['experience'].toString(),
                                specialization: consultant['specialization'],
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
  final String id;
  final String name;
  final String mobile;
  final String experience;
  final String specialization;

  ConsultantDetailsScreen({
    required this.id,
    required this.name,
    required this.mobile,
    required this.experience,
    required this.specialization,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consultant Details'), backgroundColor: Colors.orange),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            SizedBox(height: 8),
            Text('Experience: $experience years', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Specialization: $specialization', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _makeCall(mobile),
                  icon: Icon(Icons.call),
                  label: Text('Call'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton.icon(
                  onPressed: () => _sendMessage(mobile),
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
      print('❌ Could not launch $phoneNumber');
    }
  }

  // Function to send a message
  void _sendMessage(String phoneNumber) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      print('❌ Could not launch $phoneNumber');
    }
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? profileImage;
  bool isDarkMode = false;

  // Function to pick an image
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  // Function to show logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add logout logic here (e.g., clear user session and navigate to login screen)
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Center(
                child: Column(
                  children: [
                    // Profile Picture
                    GestureDetector(
                      onTap: pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.orangeAccent.withOpacity(0.5),
                        backgroundImage: profileImage != null
                            ? FileImage(profileImage!)
                            : null,
                        child: profileImage == null
                            ? Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'johndoe@example.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Personal Details
              ListTile(
                leading: Icon(Icons.person_outline, color: Colors.orangeAccent),
                title: Text('Edit Profile'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceholderScreen('Edit Profile'),
                    ),
                  );
                },
              ),
              Divider(),

              // Settings Section
              ListTile(
                leading: Icon(Icons.settings, color: Colors.orangeAccent),
                title: Text('Settings'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceholderScreen('Settings'),
                    ),
                  );
                },
              ),
              Divider(),

              // Privacy and Security
              ListTile(
                leading: Icon(Icons.lock_outline, color: Colors.orangeAccent),
                title: Text('Change Password'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PlaceholderScreen('Change Password'),
                    ),
                  );
                },
              ),
              Divider(),

              // Logout Section
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () => _showLogoutDialog(context),
              ),
              Divider(),

              // Support Section
              ListTile(
                leading: Icon(Icons.help_outline, color: Colors.orangeAccent),
                title: Text('Contact Support'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceholderScreen('Contact Support'),
                    ),
                  );
                },
              ),
              Divider(),

              // Dark Mode Toggle
              ListTile(
                leading:
                    Icon(Icons.dark_mode_outlined, color: Colors.orangeAccent),
                title: Text('Dark Mode'),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                      // Add logic to toggle dark mode in the app
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder screen for navigation
class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Text(
          '$title Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

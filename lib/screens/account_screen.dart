import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
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
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.orangeAccent.withOpacity(0.5),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
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
                  // Navigate to edit profile page
                },
              ),
              Divider(),

              // Settings Section
              ListTile(
                leading: Icon(Icons.settings, color: Colors.orangeAccent),
                title: Text('Settings'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to settings page
                },
              ),
              Divider(),

              // Privacy and Security
              ListTile(
                leading: Icon(Icons.lock_outline, color: Colors.orangeAccent),
                title: Text('Change Password'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to change password page
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
                onTap: () {
                  // Perform logout action
                },
              ),
              Divider(),

              // Support Section
              ListTile(
                leading: Icon(Icons.help_outline, color: Colors.orangeAccent),
                title: Text('Contact Support'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to support page
                },
              ),
              Divider(),

              // Optional: Dark Mode Toggle
              ListTile(
                leading:
                    Icon(Icons.dark_mode_outlined, color: Colors.orangeAccent),
                title: Text('Dark Mode'),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {
                    // Toggle dark mode
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

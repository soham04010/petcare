import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_care_finder/screens/acc_func/profile.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? profileImage;
  bool isDarkMode = false;

  String _name = '';
  String _email = '';
  String _mobile = '';
  String _address = '';

  @override
  void initState() {
    super.initState();
    _loadSavedProfile();
  }

  void _loadSavedProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _name = prefs.getString('name') ?? 'John Doe';
        _email = prefs.getString('email') ?? 'johndoe@example.com';
        _mobile = prefs.getString('mobile') ?? '';
        _address = prefs.getString('address') ?? '';
      });
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

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
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _navigateToEditProfile() async {
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );

    if (updatedProfile != null) {
      setState(() {
        _name = updatedProfile['name'] ?? _name;
        _email = updatedProfile['email'] ?? _email;
        _mobile = updatedProfile['mobile'] ?? _mobile;
        _address = updatedProfile['address'] ?? _address;
      });
    }
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
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.orangeAccent.withOpacity(0.5),
                        backgroundImage: profileImage != null
                            ? FileImage(profileImage!)
                            : null,
                        child: profileImage == null
                            ? Icon(Icons.person, size: 60, color: Colors.white)
                            : null,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    if (_mobile.isNotEmpty) 
                      Text(
                        _mobile,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              
              // Account Management Options
              _buildAccountOption(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: _navigateToEditProfile,
              ),
              _buildAccountOption(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () => _navigateToPlaceholder('Settings'),
              ),
              _buildAccountOption(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () => _navigateToPlaceholder('Change Password'),
              ),
              _buildAccountOption(
                icon: Icons.help_outline,
                title: 'Contact Support',
                onTap: () => _navigateToPlaceholder('Contact Support'),
              ),
              
              // Logout Option
              _buildLogoutOption(),
              
              // Dark Mode Toggle
              ListTile(
                leading: Icon(Icons.dark_mode_outlined, color: Colors.orangeAccent),
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

  Widget _buildAccountOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.orangeAccent),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
        Divider(),
      ],
    );
  }

  Widget _buildLogoutOption() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.logout, color: Colors.red),
          title: Text(
            'Logout',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () => _showLogoutDialog(context),
        ),
        Divider(),
      ],
    );
  }

  void _navigateToPlaceholder(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlaceholderScreen(title)),
    );
  }
}

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
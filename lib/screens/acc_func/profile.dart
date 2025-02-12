import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _loadSavedProfile();
  }

  void _loadSavedProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _nameController = TextEditingController(
          text: prefs.getString('name') ?? '',
        );
        _emailController = TextEditingController(
          text: prefs.getString('email') ?? '',
        );
        _mobileController = TextEditingController(
          text: prefs.getString('mobile') ?? '',
        );
        _addressController = TextEditingController(
          text: prefs.getString('address') ?? '',
        );
      });
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  void _saveProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setString('name', _nameController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('mobile', _mobileController.text);
      await prefs.setString('address', _addressController.text);

      Navigator.pop(context, {
        'name': _nameController.text,
        'email': _emailController.text,
        'mobile': _mobileController.text,
        'address': _addressController.text,
      });
    } catch (e) {
      print('Error saving profile: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _mobileController,
                decoration: InputDecoration(labelText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';

class AuthService {
  Future<Map<String, dynamic>?> registerUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$backendBaseUrl/auth/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$backendBaseUrl/auth/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}

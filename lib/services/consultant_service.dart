import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';

class ConsultantService {
  // Fetch consultants from the backend
  Future<List<dynamic>> fetchConsultants() async {
    try {
      final response = await http.get(
        Uri.parse('$backendBaseUrl/consultants'),
        headers: {"Content-Type": "application/json"},
      );

      print('Consultant API Response: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        if (data.isEmpty) {
          print('⚠ No consultants found.');
        } else {
          print('✅ Consultants fetched: ${data.length}');
        }

        return data;
      } else {
        print('❌ Error fetching consultants: HTTP ${response.statusCode} - ${response.body}');
        return []; // Return empty list to prevent crashes
      }
    } catch (e) {
      print('🚨 Exception while fetching consultants: $e');
      return []; // Return empty list if API call fails
    }
  }

  // Book a consultant
  Future<bool> bookConsultant(String consultantId) async {
    try {
      final response = await http.post(
        Uri.parse('$backendBaseUrl/consultants/book/$consultantId'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print('✅ Consultant booked successfully.');
        return true;
      } else {
        print('❌ Error booking consultant: HTTP ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('🚨 Exception while booking consultant: $e');
      return false;
    }
  }
}

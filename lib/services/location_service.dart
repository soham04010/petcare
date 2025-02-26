import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';

class LocationService {
  Future<List<dynamic>> findNearbyStores(double latitude, double longitude) async {
    try {
      final response = await http.get(Uri.parse('$backendBaseUrl/location/nearby?lat=$latitude&lon=$longitude'))
          .timeout(Duration(seconds: 5)); // Set timeout

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error fetching locations: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception while fetching locations: $e');
      return []; // Return empty list if there's an error
    }
  }
}

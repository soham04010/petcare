import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';

class ChatService {
  Future<List<dynamic>?> fetchChatMessages(String userId, String consultantId) async {
    final response = await http.get(Uri.parse('$backendBaseUrl/chat/$userId/$consultantId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<bool> sendMessage(String userId, String consultantId, String sender, String message) async {
    final response = await http.post(
      Uri.parse('$backendBaseUrl/chat/send'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userId": userId, "consultantId": consultantId, "sender": sender, "message": message}),
    );

    return response.statusCode == 200;
  }
}

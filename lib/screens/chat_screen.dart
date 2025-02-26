import 'package:flutter/material.dart';
import '../services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String consultantId;

  ChatScreen({required this.userId, required this.consultantId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<dynamic>? messages;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  void loadMessages() async {
    var data = await ChatService().fetchChatMessages(widget.userId, widget.consultantId);
    setState(() {
      messages = data;
    });
  }

  void sendMessage() async {
    if (_controller.text.isNotEmpty) {
      bool success = await ChatService().sendMessage(widget.userId, widget.consultantId, "User", _controller.text);
      if (success) {
        _controller.clear();
        loadMessages();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: messages == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: messages!.length,
                    itemBuilder: (context, index) {
                      var message = messages![index];
                      return ListTile(
                        title: Text(message['message']),
                        subtitle: Text("Sent by: ${message['sender']}"),
                      );
                    },
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _controller)),
                IconButton(icon: Icon(Icons.send), onPressed: sendMessage),
              ],
            ),
          )
        ],
      ),
    );
  }
}

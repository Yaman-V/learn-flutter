import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();
  final List<ChatMessage> messages = [];
  bool isLoading = false;
  final String apiKey =
      "sk-or-v1- 2c6a2d9f319b754ee406272bbdfd9000117ce7ed5419068f334807f24d9a2fe3";
  Future<void> sendMessage(String text) async {
    setState(() {
      messages.add(ChatMessage(role: "user", text: text));
      isLoading = true;
    });
    controller.clear();
    final url = Uri.parse("https://openrouter.ai/api/v1/chat/completions");
    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
        "HTTP-Referer": "http://localhost",
        "X-Title": "Flutter Chat App",
      },
      body: jsonEncode({
        "model": "google/gemma-4-31b-it:free",
        "messages": messages
            .map((m) => {"role": m.role, "content": m.text})
            .toList(),
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reply = data["choices"][0]["message"]["content"];
      setState(() {
        messages.add(ChatMessage(role: "assistant", text: reply));
        isLoading = false;
      });
    } else {
      setState(() {
        messages.add(
          ChatMessage(role: "assistant", text: "Error: ${response.body}"),
        );
        isLoading = false;
      });
    }
  }

  Widget buildMessage(ChatMessage msg) {
    final isUser = msg.role == "user";
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg.text,
          style: TextStyle(color: isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OpenRouter Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => buildMessage(messages[index]),
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: isLoading
                      ? null
                      : () {
                          final text = controller.text.trim();
                          if (text.isNotEmpty) {
                            sendMessage(text);
                          }
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String role;
  final String text;
  ChatMessage({required this.role, required this.text});
}

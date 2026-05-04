import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  ChatMessage({required this.text, required this.isMe, required this.time});
}

class ChatContact {
  final String name;
  final String lastMessage;
  final String avatarPath;
  final int unreadCount;

  ChatContact({required this.name, required this.lastMessage, required this.avatarPath, this.unreadCount = 0});
}

class ChatController extends GetxController {
  var messages = <ChatMessage>[
    ChatMessage(text: "I'm interested in building lean muscle.", isMe: true, time: "11:15 AM"),
    ChatMessage(text: "Great! Let's start with your current diet.", isMe: false, time: "11:15 AM"),
    ChatMessage(text: "I try to eat a balanced diet, but I'm not sure if I'm getting enough protein.", isMe: true, time: "11:16 AM"),
    ChatMessage(text: "Okay, we can definitely work on that.", isMe: false, time: "11:16 AM"),
  ].obs;

  var contacts = <ChatContact>[
    ChatContact(name: "Kira Hanning", lastMessage: "Sent a file", avatarPath: "assets/images/user1.png", unreadCount: 1),
    ChatContact(name: "Liam O'Sullivan", lastMessage: "Commented on the project", avatarPath: "assets/images/user2.png", unreadCount: 1),
    ChatContact(name: "Maya Chen", lastMessage: "Uploaded images", avatarPath: "assets/images/user3.png"),
    ChatContact(name: "Ethan Kim", lastMessage: "Reviewed the document", avatarPath: "assets/images/user4.png"),
    ChatContact(name: "Sofia Martinez", lastMessage: "Shared a link", avatarPath: "assets/images/user5.png"),
  ].obs;

  final messageController = TextEditingController();
  final searchController = TextEditingController();

  void sendMessage() {
    String text = messageController.text.trim();
    if (text.isNotEmpty) {
      messages.add(ChatMessage(text: text, isMe: true, time: "Now"));
      messageController.clear();
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    searchController.dispose();
    super.onClose();
  }
}

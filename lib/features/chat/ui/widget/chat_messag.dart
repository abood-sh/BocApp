// // chat_message.dart
// import 'package:doc_app/features/chat/data/model/message_model.dart';
// import 'package:doc_app/features/chat/ui/widget/message_bubble.dart';
// import 'package:flutter/material.dart';

// class ChatMessage extends StatelessWidget {
//   final String currentUserId; // Add current user ID
//   final String receiverId;
  
//   ChatMessage({
//     super.key,
//     required this.currentUserId, // Get from your auth system
//     required this.receiverId,
//   });

//   // Temporary hardcoded messages (remove when using real data)
//   final message = [
//     MessageModel(
//         senderId: "MYLVeZvYVXPsnCo84lOJ",
//         receiverId: "2",
//         content: "Hello",
//         sentTime: DateTime.now(),
//         messageType: MessageType.text),
//     MessageModel(
//         senderId: "2",
//         receiverId: "MYLVeZvYVXPsnCo84lOJ",
//         content: "Hi",
//         sentTime: DateTime.now(),
//         messageType: MessageType.text),
//     MessageModel(
//         senderId: "2",
//         receiverId: "MYLVeZvYVXPsnCo84lOJ",
//         content: "How are you",
//         sentTime: DateTime.now(),
//         messageType: MessageType.text),
//     MessageModel(
//         senderId: "MYLVeZvYVXPsnCo84lOJ", // Changed sender to current user
//         receiverId: "2",
//         content: "https://example.com/image.jpg",
//         sentTime: DateTime.now(),
//         messageType: MessageType.image),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       reverse: true, // Show latest messages at bottom
//       itemCount: message.length,
//       itemBuilder: (context, index) {
//         final message = messages[index];
//         final isMe = currentUserId == message.senderId; // Fixed isMe logic
//         final isImage = message.messageType == MessageType.image;
        
//         return MessageBubble(
//           messageModel: message,
//           isMe: isMe,
//           isImage: isImage,
//         );
//       },
//     );
//   }
// }
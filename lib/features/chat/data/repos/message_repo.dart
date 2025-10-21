// lib/features/chat/data/repo/chat_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/features/chat/data/model/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get currentUserId => _auth.currentUser!.uid;

  Stream<List<MessageModel>> getMessages(String receiverId) {
    final chatRoomId = _getChatRoomId(currentUserId, receiverId);

    return _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          final messages = snapshot.docs
              .map((doc) => MessageModel.fromMap(doc.data()))
              .toList();

          // Mark messages as read
          _markMessagesAsRead(chatRoomId, receiverId);

          return messages;
        });
  }

  Future<void> sendMessage({
    required String receiverId,
    required String content,
  }) async {
    final chatRoomId = _getChatRoomId(currentUserId, receiverId);
    final messageId = _firestore.collection('chats').doc().id;
    final timestamp = DateTime.now();

    final message = MessageModel(
      id: messageId,
      senderId: currentUserId,
      receiverId: receiverId,
      content: content,
      timestamp: timestamp,
    );

    await _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());

    // Update last message in chat room
    await _updateLastMessage(chatRoomId, message);
  }

  Future<void> _markMessagesAsRead(String chatRoomId, String senderId) async {
    final batch = _firestore.batch();

    final unreadMessages = await _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .where('senderId', isEqualTo: senderId)
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in unreadMessages.docs) {
      batch.update(doc.reference, {'isRead': true});
    }

    await batch.commit();
  }

  Future<void> _updateLastMessage(
    String chatRoomId,
    MessageModel message,
  ) async {
    await _firestore.collection('chats').doc(chatRoomId).set({
      'lastMessage': message.content,
      'lastMessageTime': message.timestamp,
      'participants': [message.senderId, message.receiverId],
    }, SetOptions(merge: true));
  }

  String _getChatRoomId(String userId1, String userId2) {
    final List<String> ids = [userId1, userId2];
    ids.sort();
    return ids.join('_');
  }
}

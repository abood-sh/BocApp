// lib/features/chat/ui/screens/chat_screen.dart
import 'package:doc_app/features/chat/logic/cubit/chat_cubit.dart';
import 'package:doc_app/features/chat/logic/cubit/chat_state.dart';
import 'package:doc_app/features/chat/ui/widget/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const ChatScreen({
    Key? key,
    required this.receiverId,
    required this.receiverName,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().startChat(widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverName)),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(child: _buildMessageList(state)),
              _buildMessageInput(state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageList(ChatState state) {
    if (state is ChatLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ChatError) {
      return Center(child: Text(state.message));
    }

    if (state is ChatLoaded) {
      return ListView.builder(
        controller: _scrollController,
        reverse: true,
        itemCount: state.messages.length,
        itemBuilder: (context, index) {
          final message = state.messages[index];
          final currentUserId = FirebaseAuth.instance.currentUser!.uid;
          final isMe = message.senderId == currentUserId;
          final isImage =
              message.content.startsWith('http') &&
              (message.content.endsWith('.jpg') ||
                  message.content.endsWith('.jpeg') ||
                  message.content.endsWith('.png'));

          return MessageBubble(message: message, isMe: isMe, isImage: isImage);
        },
      );
    }

    return const SizedBox();
  }

  Widget _buildMessageInput(ChatState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
              enabled: state is! ChatLoading,
            ),
          ),
          const SizedBox(width: 8),
          _buildSendButton(state),
        ],
      ),
    );
  }

  Widget _buildSendButton(ChatState state) {
    final isSending = state is ChatLoaded && state.isSending;

    return IconButton(
      icon: isSending
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.send),
      onPressed: isSending ? null : () => _sendMessage(),
    );
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      context.read<ChatCubit>().sendMessage(
        receiverId: widget.receiverId,
        content: message,
      );
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

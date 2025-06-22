import 'package:doc_app/core/helpers/app_regex.dart';
import 'package:doc_app/core/helpers/spacing.dart';
import 'package:doc_app/core/theming/colors.dart';
import 'package:doc_app/core/widget/app_text_form_field.dart';
import 'package:doc_app/features/chat/logic/cubit/user_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTextField extends StatefulWidget {
  final String receiverID;
  final Function(String) onSendText;
  final Function() onSendImage;

  const ChatTextField({
    super.key,
    required this.receiverID,
    required this.onSendText,
    required this.onSendImage,
  });

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Add Message...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onSendText(_controller.text);
              _controller.clear();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: widget.onSendImage,
        ),
      ],
    );
  }
}

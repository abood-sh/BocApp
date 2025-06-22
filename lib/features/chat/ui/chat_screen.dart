import 'package:doc_app/core/helpers/spacing.dart';
import 'package:doc_app/core/theming/colors.dart';
import 'package:doc_app/core/theming/styles.dart';
import 'package:doc_app/features/chat/data/model/message_model.dart';
import 'package:doc_app/features/chat/data/model/user_model.dart';
import 'package:doc_app/features/chat/data/repos/message_repo.dart';
import 'package:doc_app/features/chat/logic/cubit/chat_cubit.dart';
import 'package:doc_app/features/chat/logic/cubit/chat_state.dart';
import 'package:doc_app/features/chat/ui/widget/chat_messag.dart';
import 'package:doc_app/features/chat/ui/widget/chat_text_field.dart';
import 'package:doc_app/features/chat/ui/widget/message_bubble.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatCubit _chatCubit;
  @override
  void initState() {
    super.initState();
    _chatCubit = ChatCubit(
      messageRepository: context.read<MessageRepository>(),
      currentUserId: 'current_user_id', // Get from your auth system
      receiverId: widget.userModel.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _chatCubit,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: ColorsManager.white,
          elevation: 0,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.userModel.profileImageUrl),
                radius: 20.r,
              ),
              horizontalSpace(10),
              Column(
                children: [
                  Text(
                    widget.userModel.name,
                    style: TextStyles.font18DarkBlueBold,
                  ),
                  Text(
                    widget.userModel.isOnline ? "Online" : "Offline",
                    style: widget.userModel.isOnline
                        ? TextStyles.font14BlueSemiBold
                        : TextStyles.font14GrayRegular,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    return StreamBuilder<List<MessageModel>>(
                      stream: context.read<ChatCubit>().messagesStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }

                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final messages = snapshot.data!;
                        return ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final isMe =
                                message.senderId == _chatCubit.currentUserId;
                            final isImage =
                                message.messageType == MessageType.image;

                            return MessageBubble(
                              messageModel: message,
                              isMe: isMe,
                              isImage: isImage,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              ChatTextField(
                receiverID: widget.userModel.uid,
                onSendImage: () {
                  _pickAndSendImage();
                },
                onSendText: (text) {
                  _chatCubit.sendTextMessage(text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAndSendImage() async {
    // Implement image picking using image_picker
    // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // if (image != null) {
    //   final imageUrl = await uploadImageToStorage(image);
    //   _chatCubit.sendImageMessage(imageUrl);
    // }
  }
}

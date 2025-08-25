import 'package:doc_app/core/helpers/spacing.dart';
import 'package:doc_app/core/theming/colors.dart';
import 'package:doc_app/core/theming/styles.dart';
import 'package:doc_app/features/chat/data/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.messageModel,
    required this.isMe,
    required this.isImage,
  });
  final MessageModel messageModel;
  final bool isMe;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.topLeft : Alignment.topRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          isImage
              ? Container(
                  constraints: BoxConstraints(
                    maxWidth: 250.w,
                    maxHeight: 400.h,
                    minHeight: 200.h,
                    minWidth: 200.w,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? ColorsManager.mainBlue : ColorsManager.gray,
                    borderRadius: isMe
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          )
                        : const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                    image: DecorationImage(
                      image: NetworkImage(messageModel.content),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: isMe ? ColorsManager.mainBlue : ColorsManager.gray,
                    borderRadius: isMe
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          )
                        : const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    messageModel.content,
                    style: TextStyles.font14WhiteSemiBold(context),
                  ),
                ),
          verticalSpace(3),
          Text(
            // timeago.format(messageModel.sentTime.toLocal()),
            '${messageModel.sentTime.toLocal().toString().substring(0, 10)} '
            '${TimeOfDay.fromDateTime(messageModel.sentTime.toLocal()).format(context)}',
            style: TextStyles.font8GrayRegular(context),
          ),
        ],
      ),
    );
  }
}

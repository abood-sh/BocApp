import 'package:doc_app/core/di/dependency_injection.dart';
import 'package:doc_app/core/theming/colors.dart';
import 'package:doc_app/core/theming/styles.dart';
import 'package:doc_app/features/chat/data/model/user_model.dart';
import 'package:doc_app/features/chat/data/repos/message_repo.dart';
import 'package:doc_app/features/chat/logic/cubit/user_cubit.dart';
import 'package:doc_app/features/chat/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserListViewItem extends StatelessWidget {
  final UserModel? userModel;
  final int itemIndex;
  const UserListViewItem({
    super.key,
    required this.userModel,
    required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RepositoryProvider(
                  create: (context) => getIt<MessageRepository>(),
                  child: BlocProvider(
                    create: (context) => UserCubit(getIt()),
                    child: ChatScreen(userModel: userModel!),
                  ),
                ),
              ),
            );
          },
          child: ListTile(
            key: ValueKey(userModel?.uid),
            contentPadding: EdgeInsets.zero,
            leading: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(userModel!.profileImageUrl),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 11.h),
                  child: CircleAvatar(
                    backgroundColor: userModel!.isOnline
                        ? Colors.green
                        : Colors.grey, // Online status indicator
                    radius: 4,
                  ),
                ),
              ],
            ),
            title: Text(
              userModel!.name,
              style: TextStyles.font18DarkBlueBold(context),
            ),
            subtitle: Text(
              'Last Activity ${timeago.format(userModel!.lastActivity)}',
              style: TextStyles.font14GrayRegular(context),
            ),
          ),
        ),
        const Divider(color: ColorsManager.lightGray, thickness: 1, height: 0),
      ],
    );
  }
}

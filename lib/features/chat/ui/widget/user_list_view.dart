import 'package:doc_app/core/helpers/spacing.dart';
import 'package:doc_app/features/chat/data/model/user_model.dart';
import 'package:doc_app/features/chat/ui/widget/user_list_view_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserListView extends StatelessWidget {
  final List<UserModel> userModelData;

  const UserListView({super.key, required this.userModelData});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const PageStorageKey<String>('users_list'),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      separatorBuilder: (context, index) => verticalSpace(10),
      itemCount: userModelData.length,
      itemBuilder: (context, index) {
        return UserListViewItem(
          userModel: userModelData[index],
          itemIndex: index,
        );
      },
    );
  }
}

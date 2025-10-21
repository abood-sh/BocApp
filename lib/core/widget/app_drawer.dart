// lib/widgets/app_drawer.dart

import 'package:doc_app/core/helpers/constants.dart';
import 'package:doc_app/core/helpers/extension.dart';
import 'package:doc_app/core/helpers/shared_pref_helper.dart';
import 'package:doc_app/core/networking/dio_factory.dart';
import 'package:doc_app/core/routing/routers.dart';
import 'package:doc_app/features/login/logic/cubit/login_cubit.dart';
import 'package:doc_app/features/login/logic/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              'Menu',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Language'),
            leading: Icon(Icons.language),
            onTap: () {
              context.pushNamed(Routers.localScreen);
            },
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Dark Mode'),
            leading: Icon(Icons.dark_mode),
            onTap: () {
              context.pushNamed(Routers.darkScreen);
            },
          ),
          ListTile(
            title: Text('Stripe Pay'),
            leading: Icon(Icons.payment),
            onTap: () {
              context.pushNamed(Routers.stripeScreen);
            },
          ),
          ListTile(
            title: Text('Chat'),
            leading: Icon(Icons.payment),
            onTap: () {
              context.pushNamed(Routers.chatScreen);
            },
          ),

          ListTile(
            title: Text('logout'),
            leading: Icon(Icons.logout),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Logout'),
                    content: Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Logout'),
                        onPressed: () async {
                          logoutAndDeleteUserToken(context);
                        },
                      ),
                    ],
                  );
                },
              );
              return;
            },
          ),
        ],
      ),
    );
  }

  logoutAndDeleteUserToken(BuildContext context) async {
    Navigator.of(context).pop();
    await SharedPrefHelper.clearAllSecuredData();
    DioFactory.removeTokenFromHeader();
    isLoggedInUser = false;
    context.pushNamedAndRemoveUntil(Routers.loginScreen);
  }
}

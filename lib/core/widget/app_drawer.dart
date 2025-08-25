// lib/widgets/app_drawer.dart

import 'package:doc_app/core/helpers/extension.dart';
import 'package:doc_app/core/routing/routers.dart';
import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}

import 'package:doc/core/helpers/extension.dart';
import 'package:flutter/material.dart';

import '../../../routing/routers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.pushNamedAndRemoveUntil(Routers.loginScreen);
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
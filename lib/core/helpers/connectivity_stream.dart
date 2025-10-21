import 'package:doc_app/features/no_internet/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Emits one initial value based on hasInternetAccess, then live changes.
Stream<InternetStatus> connectivityStream() async* {
  final conn = InternetConnection();
  final has = await conn.hasInternetAccess;
  yield has ? InternetStatus.connected : InternetStatus.disconnected;
  yield* conn.onStatusChange;
}

/// Drop-in builder for MaterialApp.builder
Widget connectivityGateBuilder(BuildContext context, Widget? appChild) {
  return StreamBuilder<InternetStatus>(
    stream: connectivityStream(),
    builder: (context, snapshot) {
      final online = snapshot.data == InternetStatus.connected;
      if (!online) {
        return NoInternetScreen(
          onRetry: () => InternetConnection().hasInternetAccess,
        );
      }
      return appChild ?? const SizedBox.shrink();
    },
  );
}

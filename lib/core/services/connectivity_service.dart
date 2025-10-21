// import 'dart:async';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// class ConnectivityService {
//   final InternetConnection _connectionChecker = InternetConnection();
//   StreamSubscription<InternetStatus>? _connectionSubscription;

//   final StreamController<bool> connectionStatusController =
//       StreamController<bool>.broadcast();

//   bool hasConnection = true;

//   ConnectivityService() {
//     _initialize();
//   }

//   void _initialize() {
//     // Listen for status changes
//     _connectionSubscription = _connectionChecker.onStatusChange.listen((
//       status,
//     ) {
//       hasConnection = status == InternetStatus.connected;
//       connectionStatusController.add(hasConnection);
//     });

//     // Check initial connection status
//     checkConnection();
//   }

//   /// Checks current internet connection status
//   /// Returns true if connected, false otherwise
//   Future<bool> checkConnection() async {
//     try {
//       hasConnection = await _connectionChecker.hasInternetAccess;
//       connectionStatusController.add(hasConnection);
//       return hasConnection;
//     } catch (e) {
//       hasConnection = false;
//       connectionStatusController.add(false);
//       return false;
//     }
//   }

//   /// Dispose resources when no longer needed
//   void dispose() {
//     _connectionSubscription?.cancel();
//     connectionStatusController.close();
//   }
// }

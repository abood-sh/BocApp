import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseLogger {
  const FirebaseLogger._();

  static void logConfiguration(FirebaseOptions options) {
    debugPrint('''
╔══════════════════════════════════════════════════════════════
║ 🔥 FIREBASE CONFIGURATION
╠══════════════════════════════════════════════════════════════
║ Project ID: ${options.projectId}
║ App ID: ${options.appId}
║ API Key: ${_maskApiKey(options.apiKey)}
║ Storage Bucket: ${options.storageBucket}
║ Messaging Sender ID: ${options.messagingSenderId}
╚══════════════════════════════════════════════════════════════
    ''');
  }

  static void logSuccess() {
    debugPrint('''
╔══════════════════════════════════════════════════════════════
║ ✅ FIREBASE INITIALIZED SUCCESSFULLY
╚══════════════════════════════════════════════════════════════
    ''');
  }

  static void logError(dynamic error) {
    debugPrint('''
╔══════════════════════════════════════════════════════════════
║ ❌ FIREBASE INITIALIZATION ERROR
╠══════════════════════════════════════════════════════════════
║ ${error.toString()}
╚══════════════════════════════════════════════════════════════
    ''');
  }

  static String _maskApiKey(String apiKey) {
    if (apiKey.length <= 8) return '****';
    return '${apiKey.substring(0, 4)}${'*' * (apiKey.length - 8)}${apiKey.substring(apiKey.length - 4)}';
  }
}

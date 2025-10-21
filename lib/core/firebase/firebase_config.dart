import 'package:firebase_core/firebase_core.dart';
import 'config/firebase_options.dart';
import 'config/firebase_logger.dart';

class FirebaseConfig {
  FirebaseConfig._();
  static final FirebaseConfig _instance = FirebaseConfig._();
  static FirebaseConfig get instance => _instance;

  bool _isInitialized = false;

  Future<void> initializeFirebase() async {
    if (_isInitialized) return;

    try {
      final options = DefaultFirebaseOptions.currentPlatform;
      FirebaseLogger.logConfiguration(options);

      await Firebase.initializeApp(options: options);
      FirebaseLogger.logSuccess();
      _isInitialized = true;
    } catch (e) {
      FirebaseLogger.logError(e);
      rethrow;
    }
  }

  bool get isInitialized => _isInitialized;
}

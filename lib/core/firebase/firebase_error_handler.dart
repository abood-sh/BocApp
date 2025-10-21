import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static String handle(FirebaseAuthException error) {
    switch (error.code) {
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'invalid-email':
        return 'Invalid email address format';
      case 'operation-not-allowed':
        return 'Email/password sign up is not enabled';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      default:
        return error.message ?? 'An authentication error occurred';
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDbHandler {
  static String handle(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return 'You don\'t have permission to access this data';
      case 'not-found':
        return 'Document not found';
      case 'already-exists':
        return 'Document already exists';
      case 'failed-precondition':
        return 'Operation failed. Please try again';
      case 'unavailable':
        return 'Service temporarily unavailable';
      default:
        return error.message ?? 'A database error occurred';
    }
  }
}

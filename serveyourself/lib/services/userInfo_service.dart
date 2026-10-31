import 'package:firebase_auth/firebase_auth.dart';

class UserInfoService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get the current user object
  static User? get currentUser => _auth.currentUser;

  /// Get current user's UID
  static String? getUserId() => _auth.currentUser?.uid;

  /// Get current user's email
  static String? getUserEmail() => _auth.currentUser?.email;

  /// Get current user's display name
  static String? getUserDisplayName() => _auth.currentUser?.displayName;

  /// Get current user's photo URL
  static String? getUserPhotoURL() => _auth.currentUser?.photoURL;

  /// Check if a user is signed in
  static bool isSignedIn() => _auth.currentUser != null;

  /// Sign out the current user
  static Future<void> signOut() async {
    await _auth.signOut();
  }
}

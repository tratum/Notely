import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class AuthServiceHandler {
  static Future<void> signInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw Exception('Error during anonymous sign-in: ${e.message}');
    } catch (e) {
      throw Exception('An unknown error occurred during anonymous sign-in: $e');
    }
  }

  static User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  static Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception('Error during sign out: ${e.message}');
    } catch (e) {
      throw Exception('An unknown error occurred during sign out: $e');
    }
  }

  static Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges();
  }
}

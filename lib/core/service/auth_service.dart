import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../app_logger.dart';

/// Service class responsible for handling authentication using Firebase.
///
/// Provides methods for signing in and signing up with email/password,
/// signing in with Google, signing out, and logging user data to Firestore.
class AuthService {
  /// Singleton instance of [AuthService].
  static final AuthService _instance = AuthService._internal();

  /// Factory constructor to return the singleton instance.
  factory AuthService() => _instance;

  AuthService._internal() {
    AppLogger.info('AuthService initialized');
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Returns the currently signed-in user, if any.
  User? get currentUser => _auth.currentUser;

  /// Signs in a user with email and password.
  ///
  /// Returns the authenticated [User] object if successful.
  /// Throws an error message if sign-in fails.
  Future<User?> signInWithEmail(String email, String password) async {
    AppLogger.info('Attempting email sign-in for $email');
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await _logUserData(credential.user!);
      AppLogger.verbose(
          'Email sign-in successful for ${credential.user!.email}');
      return credential.user;
    } on FirebaseAuthException catch (e) {
      final errorMessage = _mapAuthException(e);
      AppLogger.error('Sign-in failed: $errorMessage');
      AppLogger.handle(e, StackTrace.current, 'FirebaseAuthException');
      throw errorMessage;
    }
  }

  /// Registers a new user with email and password.
  ///
  /// Returns the authenticated [User] object if successful.
  /// Throws an error message if sign-up fails.
  Future<User?> signUpWithEmail(String email, String password) async {
    AppLogger.info('Attempting email sign-up for $email');
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await _logUserData(credential.user!);
      AppLogger.verbose(
          'Email sign-up successful for ${credential.user!.email}');
      return credential.user;
    } on FirebaseAuthException catch (e) {
      final errorMessage = _mapAuthException(e);
      AppLogger.error('Sign-up failed: $errorMessage');
      AppLogger.handle(e, StackTrace.current, 'FirebaseAuthException');
      throw errorMessage;
    }
  }

  /// Signs in a user using Google authentication.
  ///
  /// Returns the authenticated [User] object if successful.
  /// Throws an error message if sign-in fails.
  Future<User?> signInWithGoogle() async {
    AppLogger.info('Attempting Google sign-in');
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        AppLogger.warning('Google sign-in cancelled by user');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      AppLogger.debug('Google auth token received');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      await _logUserData(userCredential.user!);
      AppLogger.verbose(
          'Google sign-in successful for ${userCredential.user!.email}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      final errorMessage = _mapAuthException(e);
      AppLogger.error('Google sign-in failed: $errorMessage');
      AppLogger.handle(e, StackTrace.current, 'FirebaseAuthException');
      throw errorMessage;
    }
  }

  /// Logs user data to Firestore for tracking and analytics purposes.
  Future<void> _logUserData(User user) async {
    AppLogger.info('Logging user data for ${user.email}');
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'displayName': user.displayName ?? 'New User',
        'email': user.email,
        'photoURL': user.photoURL,
        'lastSignIn': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      AppLogger.verbose('User data logged successfully for ${user.email}');
    } catch (e) {
      AppLogger.error('Failed to log user data: $e');
      AppLogger.handle(e, StackTrace.current, 'Firestore error');
      rethrow;
    }
  }

  /// Signs out the currently authenticated user.
  Future<void> signOut() async {
    AppLogger.info('Signing out user');
    await _auth.signOut();
    AppLogger.verbose('User signed out successfully');
  }

  /// Maps FirebaseAuthException error codes to user-friendly messages.
  String _mapAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email. Please sign up first.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'This email is already registered. Please sign in.';
      case 'weak-password':
        return 'The password is too weak (minimum 6 characters).';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'invalid-credential':
        return 'The supplied credential is incorrect or expired.';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }
}

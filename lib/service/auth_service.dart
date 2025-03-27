import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await _logUserData(credential.user!);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await _logUserData(credential.user!);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      await _logUserData(userCredential.user!);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  Future<void> _logUserData(User user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'displayName': user.displayName ?? 'New User',
        'email': user.email,
        'photoURL': user.photoURL,
        'lastSignIn': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Failed to log user data: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

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

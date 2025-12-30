import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isAuthLoading = true;
  
  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isAuthLoading => _isAuthLoading;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      _isAuthLoading = false;
      notifyListeners();
    });
  }

  Future<String?> signUp(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateDisplayName(username);
      await userCredential.user?.reload();
      _user = _auth.currentUser;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      debugPrint('Error signing up: $e');
      return 'An unknown error occurred';
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      debugPrint('Error logging in: $e');
      return 'An unknown error occurred';
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      debugPrint('Error resetting password: $e');
      return 'An unknown error occurred';
    }
  }

  Future<void> reloadUser() async {
    await _user?.reload();
    _user = _auth.currentUser;
    notifyListeners();
  }
}
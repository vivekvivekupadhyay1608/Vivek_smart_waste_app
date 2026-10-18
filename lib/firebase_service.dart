import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. Register User & Save Data in Firestore
  static Future<User?> registerUser({
    required String email,
    required String password,
    required String fullName,
    required String role,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? user = credential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'fullName': fullName.trim(),
          'email': email.trim(),
          'role': role,
          'status': 'Pending',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return user;
    } catch (e) {
      print("❌ Registration Error: $e");
      rethrow;
    }
  }

  // 2. Login User
  static Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return credential.user;
    } catch (e) {
      print("❌ Login Error: $e");
      rethrow;
    }
  }

  // 3. Password Reset Email
  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      print("❌ Password Reset Error: $e");
      rethrow;
    }
  }

  // 4. Sign Out
  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
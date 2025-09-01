import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream untuk mendengarkan status autentikasi
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Method untuk login
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Login gagal: $e');
    }
  }

  // Method untuk logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
} 
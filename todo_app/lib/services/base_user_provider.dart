import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseUserProvider {
  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<void> createUserWithEmailAndPassword(String email, String password);

  Future<void> sendResetPasswordEmail(String email);

  Future<void> signOut();
}

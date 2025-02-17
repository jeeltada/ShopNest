import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../models/user_model.dart';

abstract class BaseAuthRepository {
  Stream<auth.User?> get user;

  Future<auth.User?> signUp({
    required User user,
    required String password,
  });

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> logInWithGoogle();
  Future<void> signOut();
}

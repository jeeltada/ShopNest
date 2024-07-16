import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopnestt_new/repositories/user/user_repository.dart';
import '../../models/user_model.dart';
import 'base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final UserRepository _userRepository;

  AuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    required UserRepository userRepository,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(scopes: ['email']),
        _userRepository = userRepository;

  @override
  Future<firebase_auth.User?> signUp({
    required User user,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      await _userRepository.createUser(user.copyWith(id: credential.user!.uid));
      return credential.user;
    } catch (e) {
      print('Sign up failed: $e');
      return null;
    }
  }

  @override
  Future<void> loginWithEmailAndPassword({
    String email = "jeeltada@gmail.com",
    String password = "supersecret",
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User signed in: ${user}');
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('Login with email and password failed: ${e.code} - ${e.message}');
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-credential') {
        print('The supplied auth credential is incorrect, malformed, or has expired.');
      }
    } catch (e) {
      print('Login with email and password failed: $e');
    }
  }

  @override
  Stream<firebase_auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> logInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final firebase_auth.AuthCredential credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential = await _firebaseAuth.signInWithCredential(credential);
        await _userRepository.createUser(User(
          id: userCredential.user!.uid,
          fullName: userCredential.user!.displayName ?? '',
          email: userCredential.user!.email ?? '',
        ));
      }
    } catch (e) {
      print('Google sign-in failed: $e');
    }
  }
}

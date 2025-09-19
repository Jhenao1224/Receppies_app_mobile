import 'package:firebase_auth/firebase_auth.dart';
import 'package:receipes_app/data/models/user_model.dart';
import 'package:receipes_app/domain/entities/auth_results.dart';
import 'package:receipes_app/domain/entities/user_entity.dart';
import 'package:receipes_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<AuthResults> signIn(String email, String password) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if(credentials.user != null){
        final user = UserEntity(
          id: credentials.user!.uid,
          name: credentials.user!.displayName!,
          email: credentials.user!.email!,
        );
        return AuthResults.sucess(user);
      }else{
        return AuthResults.error('Sign in failed.');
      }
    } catch (e) {
      return AuthResults.error('Something went wrong: ${e.toString()}');
    }
  }

  @override
  Future<AuthResults> signUp(String name, String email, String password) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if(credentials.user != null){
        await credentials.user!.updateDisplayName(name);
        final user = UserModel(
          id: credentials.user!.uid,
          name: name,
          email: email,
        );
        return AuthResults.sucess(user);
      }else{
        return AuthResults.error('Sign up failed.');
      }
    } on FirebaseAuthException catch (e) {
      return AuthResults.error(_getErrorMessage(e));
    }
    catch (e) {
      return AuthResults.error('Something went wrong: ${e.toString()}');
    }
  }
  
  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  
  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if(user != null){
      return UserModel(
        id: user.uid,
        name: user.displayName!,
        email: user.email!,
      );
    }
    return null;
  }

  @override
  Stream<UserEntity?> get authStateChanges{
    return _firebaseAuth.authStateChanges().map((user) {
      if(user != null){
        return UserModel(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
      }
      return null;
    });
  }
  



  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'email-already-in-use':
        return 'The email is already in use by another account.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'invalid-credential':
        return 'Invalid email and password combination.'; 
      default:
        return 'An undefined Error happened.';
    }
  }
}
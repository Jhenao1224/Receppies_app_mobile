import 'package:receipes_app/domain/entities/auth_results.dart';
import 'package:receipes_app/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<AuthResults> signIn(String email, String password);
  Future<AuthResults> signUp(String name,String email, String password);
  Future<void> signOut(); 
  Future<UserEntity?> getCurrentUser();
  Stream<UserEntity?> get authStateChanges;
}
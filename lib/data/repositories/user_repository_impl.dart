import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:receipes_app/data/models/user_model.dart';
import 'package:receipes_app/domain/entities/user_entity.dart';
import 'package:receipes_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  static const String _collection = 'users';
  UserRepositoryImpl(this._firestore);

  @override
  Future<void> saveUserProfile(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      await _firestore.collection(_collection).doc(user.id).set(userModel.toJson());
    } catch (e) {
      throw Exception('Failed to save user: ${e.toString()}');
    }
  }  

  @override
  Future<UserEntity?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(userId).get();
      if (doc.exists && doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        return UserModel.fromJsom(data);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user profile: ${e.toString()}');
    }
  }

  @override
  Future<void> updateUserProfile(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      await _firestore.collection(_collection).doc(userModel.id).update(userModel.toJson());
    } catch (e) {
      throw Exception('Failed to update user profile: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteUserProfile(String userId) async {
    try {
      await _firestore.collection(_collection).doc(userId).delete();
    } catch (e) {
      throw Exception('Failed to delete user profile: ${e.toString()}');
    }
  }


}
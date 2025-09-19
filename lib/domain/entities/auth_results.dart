import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receipes_app/domain/entities/user_entity.dart';

class AuthResults extends Equatable{
  final UserEntity? user;
  final String? errorMessage;
  final bool isSuccess; 

  AuthResults({
    this.user,
    this.errorMessage,
    required this.isSuccess,
  });
  
  const AuthResults.sucess(UserEntity user) 
    : user = user,
      errorMessage = null,
      isSuccess = true;

  const AuthResults.error(String error) 
    : user = null,
      errorMessage = error,
      isSuccess = false;
      
  
  @override
  List<Object?> get props => [user, errorMessage, isSuccess];
}
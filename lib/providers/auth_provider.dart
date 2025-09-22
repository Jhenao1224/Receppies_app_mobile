import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receipes_app/domain/entities/user_entity.dart';
import 'package:receipes_app/domain/repositories/auth_repository.dart';
import 'package:receipes_app/domain/repositories/user_repository.dart';
import 'package:receipes_app/domain/usecases/sign_in_usecase.dart';
import 'package:receipes_app/domain/usecases/sign_out_usecase.dart';
import 'package:receipes_app/domain/usecases/sign_up_usecase.dart';

enum AuthState{
  initial,
  loading,
  authenticated,
  unauthenticated,
  error 
}

class AuthProvider extends ChangeNotifier{
  final SignInUsecase _signInUseCase;
  final SigUpUsecase _signUpUseCase;
  final SignOutUsecase _signOutUseCase;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthState _authState = AuthState.initial;
  UserEntity? _currentUser;
  String? _errorMessage;

  AuthState get authState => _authState;
  UserEntity? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;

  AuthProvider(
    this._signInUseCase,
    this._signUpUseCase,
    this._signOutUseCase,
    this._authRepository,
    this._userRepository,
  ){
    _initializeAuthState();
  }
  
  void _initializeAuthState() {
    _authRepository.authStateChanges.listen((user) async {
      if (user != null) {
        _currentUser = user;
        _setState(AuthState.authenticated);
        try{
          final userProfile = await _userRepository.getUserProfile(user.id);
          if (userProfile != null) {
            _currentUser = userProfile;
            notifyListeners();
          }
        }catch(e){
          print('Profile load error: ${e.toString()}');          
        }
      } else {
        _currentUser = null;
        _setState(AuthState.unauthenticated);
      }
    });
  }

  _setState(AuthState state) {
    _authState = state;
    notifyListeners();
  }

  Future <void> signIn({required String email, required String password}) async {
    _setState(AuthState.loading);
    final result = await _signInUseCase.execute(email: email, password: password);

    if (result.isSuccess) {
      _errorMessage = null;
    } else {
      print('SignIn error: ${result.errorMessage}');
      _errorMessage = result.errorMessage;
      _setState(AuthState.error);    
    }
  }

  Future<void> signUp({ required String name, required String email, required String password, required String confirmPassword}) async {
    _setState(AuthState.loading);
    final result = await _signUpUseCase.execute(name: name, email: email, password: password, confirmPassword: confirmPassword);

    if (result.isSuccess) {
      _errorMessage = null;
      
    } else {
      print('SignUp error: ${result.errorMessage}');
      _errorMessage = result.errorMessage;
      _setState(AuthState.error);    
    }
  }

  Future<void> signOut() async {
    _setState(AuthState.loading);
    await _signOutUseCase.execute();
    _currentUser = null;
    _errorMessage = null;
    _setState(AuthState.unauthenticated);
  }

  updateCurrentUser(UserEntity user) {
    _currentUser = user;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    if (_authState == AuthState.error) {
      _authState = _currentUser != null ? AuthState.authenticated : AuthState.unauthenticated;
    } 
    notifyListeners();
  }
}
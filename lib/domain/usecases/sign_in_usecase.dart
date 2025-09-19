import 'package:email_validator/email_validator.dart';
import 'package:receipes_app/domain/entities/auth_results.dart';
import 'package:receipes_app/domain/repositories/auth_repository.dart';

class SignInUsecase {
  final AuthRepository _authRepository;

  SignInUsecase(this._authRepository);

  Future<AuthResults> execute({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return AuthResults.error('Email and password are required.');
    }
    if(EmailValidator.validate(email) == false){
      return AuthResults.error('Invalid email format.');
    }

    final authResult = await _authRepository.signIn(email, password);
    return authResult;
  }

}
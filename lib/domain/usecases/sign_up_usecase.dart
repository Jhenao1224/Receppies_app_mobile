import 'package:receipes_app/constants/validator.dart';
import 'package:receipes_app/domain/entities/auth_results.dart';
import 'package:receipes_app/domain/repositories/auth_repository.dart';
import 'package:receipes_app/domain/repositories/user_repository.dart';

class SigUpUsecase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  SigUpUsecase(this._authRepository, this._userRepository);

  Future<AuthResults> execute({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      print('Usecase: Name: $name, Email: $email, Password: $password, Confirm Password: $confirmPassword');
      return AuthResults.error('All fields are required.');
    }

    if (!isValidEmail(email)) {
      return AuthResults.error('Invalid email format.');
    }

    if (password.length < 6) {
      return AuthResults.error('Password must be at least 6 characters long.');
    }

    if (password != confirmPassword) {
      return AuthResults.error('Passwords do not match.');
    }

    final authResult = await _authRepository.signUp(name, email, password);

    if (authResult.isSuccess && authResult.user != null) {
      try {
        final user = authResult.user!;
        await _userRepository.saveUserProfile(user);
        return AuthResults.sucess(user);
      } catch (e) {
        return AuthResults.error('Failed to save user profile: ${e.toString()}');
      }
    }
    // Add a return statement for the case when sign up fails
    return AuthResults.error('Registration failed. Please try again.');
  }  
}
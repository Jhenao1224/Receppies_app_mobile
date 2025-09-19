import 'package:email_validator/email_validator.dart';
import 'package:receipes_app/domain/entities/user_entity.dart';
import 'package:receipes_app/domain/repositories/user_repository.dart';

class UpdateUserProfileUsecase {
  final UserRepository _userRepository;

  UpdateUserProfileUsecase(this._userRepository);

  Future<String?> execute({
    required  UserEntity user,
    String? newName,
    String? newEmail,
    }) async {
      if (newName != null && newName.isNotEmpty) {
        return 'Name Cannot be empty';
      }

      if (newEmail != null && newEmail.isNotEmpty) {
        return 'Email Cannot be empty';
      }

      if (newEmail != null && !EmailValidator.validate(newEmail)) {
        return 'Please enter a valid email.';
      }

      try {
        final updatedUser = user.copyWith(
          name: newName ,
          email: newEmail ,
        );
        await _userRepository.updateUserProfile(updatedUser);
        return null; // Indicate success
      } catch (e) {
        return 'Failed to update profile: ${e.toString()}';
      }
    }
}
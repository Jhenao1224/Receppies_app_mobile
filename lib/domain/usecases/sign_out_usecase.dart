import 'package:receipes_app/domain/repositories/auth_repository.dart';

class SignOutUsecase {
  final AuthRepository _authRepository;

  SignOutUsecase(this._authRepository);

  Future<void> execute() async {
    await _authRepository.signOut();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:receipes_app/data/repositories/auth_repository_impl.dart';
import 'package:receipes_app/data/repositories/user_repository_impl.dart';
import 'package:receipes_app/domain/usecases/sign_in_usecase.dart';
import 'package:receipes_app/domain/usecases/sign_out_usecase.dart';
import 'package:receipes_app/domain/usecases/sign_up_usecase.dart';
import 'package:receipes_app/providers/auth_provider.dart' as auth_provider;
import 'package:receipes_app/providers/theme_provider.dart';

class DependecyInjection {
  static List<SingleChildWidget> get providers {

    // Firebase instances
    final firebaseAuth = FirebaseAuth.instance;
    final firebaseFirestore = FirebaseFirestore.instance;

    // Repositories
    final authRepository = AuthRepositoryImpl(firebaseAuth);
    final userRepository = UserRepositoryImpl(firebaseFirestore);
    
    // Usecases
    final signInUseCase = SignInUsecase(authRepository);
    final signUpUseCase = SigUpUsecase(authRepository, userRepository);
    final signOutUseCase = SignOutUsecase(authRepository);
    return [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (contex) => auth_provider.AuthProvider(
        signInUseCase, 
        signUpUseCase, 
        signOutUseCase, 
        authRepository, 
        userRepository
      )),
    ];
  }
}
import 'package:fpdart/fpdart.dart';
import 'package:frello/core/error/failure.dart';
import 'package:frello/core/usecase/usecase.dart';
import 'package:frello/features/auth/domain/entities/profile.dart';
import 'package:frello/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<Profile, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, Profile>> call(params) async {
    return await authRepository.signUpUser(
        email: params.email, name: params.name, password: params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;
  UserSignUpParams(
      {required this.email, required this.password, required this.name});
}

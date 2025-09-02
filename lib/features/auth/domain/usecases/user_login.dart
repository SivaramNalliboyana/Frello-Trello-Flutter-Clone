import 'package:fpdart/fpdart.dart';
import 'package:frello/core/error/failure.dart';
import 'package:frello/core/usecase/usecase.dart';
import 'package:frello/features/auth/domain/repository/auth_repository.dart';
import 'package:frello/features/auth/domain/entities/profile.dart';

class UserLogin implements UseCase<Profile, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, Profile>> call(UserLoginParams params) async {
    return await authRepository.loginUser(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}

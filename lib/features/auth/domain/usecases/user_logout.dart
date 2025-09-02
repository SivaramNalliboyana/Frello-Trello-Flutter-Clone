import 'package:fpdart/fpdart.dart';
import 'package:frello/core/error/failure.dart';
import 'package:frello/core/usecase/usecase.dart';
import 'package:frello/features/auth/domain/repository/auth_repository.dart';

class UserLogOut implements UseCase<void, NoParams> {
  final AuthRepository authRepository;
  const UserLogOut(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams noParams) async {
    return await authRepository.logout();
  }
}

class NoParams {}

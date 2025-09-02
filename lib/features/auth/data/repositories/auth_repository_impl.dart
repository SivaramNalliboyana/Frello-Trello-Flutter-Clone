import 'package:fpdart/fpdart.dart';
import 'package:frello/core/error/exceptions.dart';
import 'package:frello/core/error/failure.dart';
import 'package:frello/features/auth/data/datasources/auth_data_source.dart';
import 'package:frello/features/auth/domain/entities/profile.dart';
import 'package:frello/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, Profile>> loginUser(
      {required String email, required String password}) async {
    try {
      final profile =
          await authDataSource.loginUser(email: email, password: password);
      return right(profile);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> signUpUser(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final profile = await authDataSource.signUpUser(
          email: email, name: name, password: password);
      return right(profile);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final logOutResponse = await authDataSource.logout();
      return right(logOutResponse);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }
}

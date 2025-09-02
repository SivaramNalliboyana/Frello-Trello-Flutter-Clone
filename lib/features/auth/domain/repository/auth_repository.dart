import 'package:fpdart/fpdart.dart';
import 'package:frello/core/error/failure.dart';
import 'package:frello/features/auth/domain/entities/profile.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Profile>> signUpUser({
    required String email,
    required String name,
    required String password,
  });

  Future<Either<Failure, Profile>> loginUser({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();
}

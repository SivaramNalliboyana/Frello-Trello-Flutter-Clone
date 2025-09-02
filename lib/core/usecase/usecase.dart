import 'package:fpdart/fpdart.dart';
import 'package:frello/core/error/failure.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

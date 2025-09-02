import 'package:fpdart/fpdart.dart';
import 'package:frello/core/error/exceptions.dart';
import 'package:frello/core/error/failure.dart';
import 'package:frello/features/boards/data/datasources/board_remote_data_source.dart';
import 'package:frello/features/boards/data/models/board_model.dart';
import 'package:frello/features/boards/domain/entities/board.dart';
import 'package:frello/features/boards/domain/repositories/board_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BoardRepositoryImpl implements BoardRepository {
  final _client = Supabase.instance.client;

  final BoardRemoteDataSource boardRemoteDataSource;
  BoardRepositoryImpl(this.boardRemoteDataSource);

  @override
  Future<Either<Failure, Board>> createBoard({
    required String name,
    required String bg_type,
    required String bg_value,
  }) async {
    try {
      BoardModel boardModel = BoardModel(
          user_id: _client.auth.currentSession!.user.id,
          name: name,
          bg_type: bg_type,
          bg_value: bg_value);
      final createdBoard = await boardRemoteDataSource.createBoard(boardModel);
      return right(createdBoard);
    } on AppException catch (e) {
      print(e.message);
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Board>>> getBoards() async {
    try {
      final boards = await boardRemoteDataSource.getBoards();
      return right(boards);
    } on AppException catch (e) {
      print(e.message);
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getUserBoardCount() async {
    try {
      final count = await boardRemoteDataSource.getUserBoardCount();
      return right(count);
    } on AppException catch (e) {
      print(e.message);
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateBoardCount(String type) async {
    try {
      final board = await boardRemoteDataSource.updateBoardCount(type);
      return right(board);
    } on AppException catch (e) {
      print(e.message);
      return left(Failure(e.message));
    }
  }
}

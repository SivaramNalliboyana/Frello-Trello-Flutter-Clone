import 'package:fpdart/fpdart.dart';
import 'package:frello/core/error/exceptions.dart';
import 'package:frello/core/error/failure.dart';
import 'package:frello/features/boards/data/models/board_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BoardRemoteDataSource {
  Future<BoardModel> createBoard(BoardModel board);
  Future<List<BoardModel>> getBoards();
  Future<int> getUserBoardCount();
  Future<void> updateBoardCount(String type);
}

class BoardRemoteDataSourceImpl implements BoardRemoteDataSource {
  final SupabaseClient supabaseClient;
  BoardRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BoardModel> createBoard(BoardModel board) async {
    try {
      final boardData =
          await supabaseClient.from('boards').insert(board.toJson()).select();
      return BoardModel.fromJson(boardData.first);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<List<BoardModel>> getBoards() async {
    try {
      final boardData = await supabaseClient
          .from('boards')
          .select()
          .eq("user_id", supabaseClient.auth.currentSession!.user.id);
      return boardData.map((data) => BoardModel.fromJson(data)).toList();
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<int> getUserBoardCount() async {
    try {
      final countData = await supabaseClient
          .from('profiles')
          .select()
          .eq("id", supabaseClient.auth.currentSession!.user.id);
      return countData.first['boards_left'];
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<void> updateBoardCount(String type) async {
    try {
      if (type == "Creation") {
        final countData = await supabaseClient.rpc("decrease_boards",
            params: {"userid": supabaseClient.auth.currentUser!.id});
      } else {
        final countData = await supabaseClient.rpc("increase_boards",
            params: {"userid": supabaseClient.auth.currentUser!.id});
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}

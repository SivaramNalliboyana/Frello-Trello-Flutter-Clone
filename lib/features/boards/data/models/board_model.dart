import 'package:frello/features/boards/domain/entities/board.dart';

class BoardModel extends Board {
  BoardModel(
      {super.id,
      required super.user_id,
      required super.name,
      required super.bg_type,
      required super.bg_value});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': user_id,
      'name': name,
      'bg_type': bg_type,
      'bg_value': bg_value
    };
  }

  factory BoardModel.fromJson(Map<String, dynamic> map) {
    return BoardModel(
        id: map['id'],
        user_id: map['user_id'],
        name: map['name'],
        bg_type: map['bg_type'],
        bg_value: map['bg_value']);
  }
}

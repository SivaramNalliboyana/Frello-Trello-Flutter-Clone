import 'package:frello/features/boards/domain/entities/unsplash_image.dart';

class UnsplashImageModel extends UnsplashImage {
  UnsplashImageModel(
      {required super.id,
      required super.username,
      required super.imageUrl,
      required super.fullUrl});

  factory UnsplashImageModel.fromJson(Map<String, dynamic> map) {
    return UnsplashImageModel(
        id: map['id'],
        username: map['user']['name'],
        imageUrl: map['urls']['thumb'],
        fullUrl: map['urls']['full']);
  }
}

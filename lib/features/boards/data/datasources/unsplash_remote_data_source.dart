import 'package:frello/core/error/exceptions.dart';
import 'package:frello/core/secrets/app_secrets.dart';
import 'package:frello/features/boards/data/models/unsplash_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract interface class UnsplashImageRemoteDataSource {
  Future<List<UnsplashImageModel>> getUnsplashImages();
}

class UnsplashImageRemoteDataSourceImpl extends UnsplashImageRemoteDataSource {
  @override
  Future<List<UnsplashImageModel>> getUnsplashImages() async {
    try {
      String url =
          "https://api.unsplash.com/photos/random/?client_id=${UnsplashSecrets.clientId}&count=9&query='wallpaper'";
      http.Response response = await http.get(Uri.parse(url));
      print(jsonDecode(response.body));
      final List reponseBody = jsonDecode(response.body);
      return reponseBody
          .map((image) => UnsplashImageModel.fromJson(image))
          .toList();
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}

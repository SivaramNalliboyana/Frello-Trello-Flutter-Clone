import 'package:frello/features/auth/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({required super.id, required super.email, required super.name});

  factory ProfileModel.fromJson(Map<String, dynamic> profile) {
    return ProfileModel(
        id: profile['id'] ?? "",
        email: profile['email'] ?? "",
        name: profile['email'] ?? "");
  }
}

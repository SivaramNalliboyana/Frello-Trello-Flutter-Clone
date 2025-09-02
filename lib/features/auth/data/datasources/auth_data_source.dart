import 'package:frello/core/error/exceptions.dart';
import 'package:frello/features/auth/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthDataSource {
  Future<ProfileModel> signUpUser({
    required String email,
    required String name,
    required String password,
  });

  Future<ProfileModel> loginUser({
    required String email,
    required String password,
  });

  Future<void> logout();
}

class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseClient supabaseClient;
  AuthDataSourceImpl(this.supabaseClient);

  @override
  Future<ProfileModel> loginUser(
      {required String email, required String password}) async {
    try {
      final authResponse = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (authResponse.user == null) {
        throw AppException("User is null");
      }
      return ProfileModel.fromJson(authResponse.user!.toJson());
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<ProfileModel> signUpUser(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final authResponse = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {"name": name},
      );
      return ProfileModel.fromJson(authResponse.user!.toJson());
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      return await supabaseClient.auth.signOut();
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}

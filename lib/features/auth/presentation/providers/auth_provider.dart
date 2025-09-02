import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frello/core/utils/show_snackbar.dart';
import 'package:frello/features/auth/data/datasources/auth_data_source.dart';
import 'package:frello/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:frello/features/auth/domain/usecases/user_login.dart';
import 'package:frello/features/auth/domain/usecases/user_logout.dart';
import 'package:frello/features/auth/domain/usecases/user_sign_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final supaBaseClient = Supabase.instance.client;
  return AuthController(
    userSignUp: UserSignUp(
      AuthRepositoryImpl(
        AuthDataSourceImpl(supaBaseClient),
      ),
    ),
    userLogin: UserLogin(
      AuthRepositoryImpl(
        AuthDataSourceImpl(supaBaseClient),
      ),
    ),
    userLogOut: UserLogOut(
      AuthRepositoryImpl(
        AuthDataSourceImpl(supaBaseClient),
      ),
    ),
  );
});

final authUserProvider = StreamProvider.autoDispose<User?>((ref) async* {
  final authStream = Supabase.instance.client.auth.onAuthStateChange;
  await for (final authState in authStream) {
    yield authState.session?.user;
  }
});

class AuthController extends StateNotifier<AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final UserLogOut _userLogOut;
  AuthController({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required UserLogOut userLogOut,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _userLogOut = userLogOut,
        super(AuthState(status: AuthStatus.initial));

  void signUp({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    state = AuthState(status: AuthStatus.loading);
    final response = await _userSignUp
        .call(UserSignUpParams(email: email, password: password, name: name));

    response.fold(
      (failure) {
        state = AuthState(status: AuthStatus.failure, message: failure.message);
        showSnackBar(context, "Error creating account", Colors.redAccent);
      },
      (profile) {
        state = AuthState(status: AuthStatus.success, message: profile.id);
        Navigator.pop(context);
      },
    );
  }

  void logIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = AuthState(status: AuthStatus.loading);
    final response = await _userLogin
        .call(UserLoginParams(email: email, password: password));

    response.fold(
      (failure) {
        state = AuthState(status: AuthStatus.failure, message: failure.message);
        showSnackBar(context, "Error logging you in", Colors.redAccent);
      },
      (profile) {
        state = AuthState(status: AuthStatus.success, message: profile.id);
      },
    );
  }

  void logout({required BuildContext context}) async {
    final reponse = await _userLogOut.call(NoParams());
    reponse.fold((failure) {
      state = AuthState(status: AuthStatus.failure, message: failure.message);
      showSnackBar(context, "Error logging you in", Colors.redAccent);
    }, (r) {
      state = AuthState(status: AuthStatus.success, message: "Logged out");
    });
  }
}

enum AuthStatus { initial, loading, success, failure }

class AuthState {
  final AuthStatus status;
  final String? message;

  AuthState({
    required this.status,
    this.message,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frello/core/utils/loader.dart';
import 'package:frello/core/utils/my_style.dart';
import 'package:frello/features/auth/presentation/providers/auth_provider.dart';
import 'package:frello/features/auth/presentation/widgets/auth_button.dart';
import 'package:frello/features/auth/presentation/widgets/auth_text_field.dart';

class SignUpPage extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUp() {
    ref.read(authControllerProvider.notifier).signUp(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    AuthState authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sign Up",
              style: mystyle(32, Colors.white, FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 25, bottom: 25),
                child: Column(
                  children: [
                    AuthTextField(
                      hintText: "Email",
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthTextField(hintText: "Name", controller: nameController),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthTextField(
                      hintText: "Password",
                      controller: passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    authState.status == AuthStatus.loading
                        ? const Loader()
                        : AuthButton(
                            title: "Create account",
                            onPressed: () => signUp(),
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

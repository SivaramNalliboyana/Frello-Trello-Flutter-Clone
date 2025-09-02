import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frello/core/utils/loader.dart';
import 'package:frello/core/utils/my_style.dart';
import 'package:frello/features/auth/presentation/pages/sign_up_page.dart';
import 'package:frello/features/auth/presentation/providers/auth_provider.dart';
import 'package:frello/features/auth/presentation/widgets/auth_button.dart';
import 'package:frello/features/auth/presentation/widgets/auth_text_field.dart';

class LogInPage extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LogInPage(),
      );
  const LogInPage({super.key});

  @override
  ConsumerState<LogInPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void logIn() {
    ref.read(authControllerProvider.notifier).logIn(
        email: emailController.text,
        password: passwordController.text,
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
              "Frello",
              style: mystyle(35, Colors.white, FontWeight.bold),
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
                        hintText: "Email", controller: emailController),
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
                    InkWell(
                      onTap: () => Navigator.push(context, SignUpPage.route()),
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: mystyle(14, Colors.black, FontWeight.w700),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: mystyle(14, Colors.blue, FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    authState.status == AuthStatus.loading
                        ? const Loader()
                        : AuthButton(
                            title: "Log in",
                            onPressed: () => logIn(),
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

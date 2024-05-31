import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/auth/login/auth_providers.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/main_login_textfield.dart';
import 'package:masinqo/presentation/widgets/background.dart';
import 'package:masinqo/presentation/widgets/login_brand.dart';
import 'package:masinqo/presentation/widgets/login_options.dart';

class LoginWidget extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginWidget({super.key});

  void Function()? loginHandler(bool loginState, WidgetRef ref) {
    void loginH() {
      if (!loginState) {
        ref
            .read(listenerLoginProvider.notifier)
            .loginListener(_emailController.text, _passwordController.text);
      } else {
        ref
            .read(artistLoginProvider.notifier)
            .loginArtist(_emailController.text, _passwordController.text);
      }
    }

    return loginH;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceHeight = MediaQuery.of(context).size.height;
    final loginState = ref.watch(loginPageProvider);
    ref.listen(artistLoginProvider, (prev, nxt) {
      if (nxt.errors.isEmpty && nxt.token.isNotEmpty) {
        context.goNamed("artist", pathParameters: {"token": nxt.token});
      }

      if (nxt.errors.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(nxt.errors[0]),
            backgroundColor: const Color.fromARGB(255, 212, 47, 47),
          ),
        );

        ref.read(artistLoginProvider.notifier).clearErrors();
      }
    });

    ref.listen(listenerLoginProvider, (prev, nxt) {
      if (nxt.errors.isEmpty && nxt.token.isNotEmpty) {
        context.goNamed("listener", pathParameters: {"token": nxt.token});
      }

      if (nxt.errors.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(nxt.errors[0]),
            backgroundColor: const Color.fromARGB(255, 212, 47, 47),
          ),
        );

        ref.read(listenerLoginProvider.notifier).clearErrors();
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: deviceHeight,
          child: BackgroundGradient(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 10.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        context.go("/admin");
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Admin',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 17,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(22, 20, 22, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Brand(
                            text: 'Masinqo',
                            size: 50,
                          ),
                          const SizedBox(height: 10),
                          NormalLoginTextfield(
                            controller: _emailController,
                            fieldText:
                                loginState ? 'Artist Email' : 'User Email',
                            icon: Icons.mail,
                          ),
                          const SizedBox(height: 16),
                          NormalLoginTextfield(
                            controller: _passwordController,
                            fieldText: 'Password',
                            icon: Icons.lock,
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Flexible(
                                flex: 5,
                                child: LoginOptionButton(
                                  isArtist: loginState,
                                  primaryColor: AppColors.artist2,
                                  buttonText: 'Login as Artist',
                                  toValue: true,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                flex: 6,
                                child: LoginOptionButton(
                                  isArtist: loginState,
                                  primaryColor: AppColors.listener2,
                                  buttonText: 'Login as Listener',
                                  toValue: false,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go("/signup");
                      },
                      style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          foregroundColor: AppColors.fontColor),
                      child: const Text("Don't have an account?"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: loginHandler(loginState, ref),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          loginState ? AppColors.artist2 : AppColors.listener4,
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

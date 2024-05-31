import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/auth/auth_providers.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/login_brand.dart';
import 'package:masinqo/presentation/widgets/admin_login_button.dart';
import 'package:masinqo/presentation/widgets/admin_login_textfield.dart';

class AdminLogin extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AdminLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceHeight = MediaQuery.of(context).size.height;
    ref.listen(adminLoginProvider, (prev, nxt) {
      if (nxt.errors.isEmpty && nxt.token.isNotEmpty) {
        context.goNamed("admin_home", pathParameters: {"tk": nxt.token});
        return;
      }

      if (nxt.errors.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(nxt.errors[0]),
            backgroundColor: const Color.fromARGB(255, 212, 47, 47),
          ),
        );

        ref.read(adminLoginProvider.notifier).clearErrors();
      }
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: deviceHeight,
          child: Container(
            decoration: const BoxDecoration(color: AppColors.black),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50.0, right: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.go("/login");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      backgroundColor: AppColors.artist4,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          size: 19,
                          color: AppColors.artist2,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Back to user login',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Brand(
                              text: 'Masinqo Admins',
                              size: 40,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Admin Email',
                              prefixIcon: const Icon(Icons.mail),
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                        onPressed: () {
                          ref.read(adminLoginProvider.notifier).loginAdmin(
                              _emailController.text, _passwordController.text);
                        },
                        buttonText: 'Login'),
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

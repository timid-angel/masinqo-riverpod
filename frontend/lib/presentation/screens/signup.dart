import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/auth/signup/signup_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/auth/signup/signup_states.dart';
import '../widgets/login_brand.dart';
import '../core/theme/app_colors.dart';
import '../widgets/signup_textfield.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';

class SignupWidget extends ConsumerWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ValueNotifier<bool> _isArtist = ValueNotifier(true);

  SignupWidget({super.key});

  void Function()? signupHandler(WidgetRef ref) {
    void signupH() {
      if (_isArtist.value) {
        final artistDto = ArtistSignupDTO(
          name: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        );

        ref.read(artistSignupProvider.notifier).artistSignup(artistDto);
      } else {
        final listenerDto = ListenerSignupDTO(
          name: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        );

        ref.read(listenerSignupProvider.notifier).listenerSignup(listenerDto);
      }
    }

    return signupH;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceHeight = MediaQuery.of(context).size.height;
    ref.listen(artistSignupProvider, (prev, nxt) {
      if (nxt is ArtistSignupSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account created succesfully!"),
            backgroundColor: Color.fromARGB(255, 73, 158, 27),
          ),
        );
        Future.delayed(const Duration(milliseconds: 1500))
            .then((d) => context.go("/login"));
      } else if (nxt is ArtistSignupFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(nxt.error),
            backgroundColor: const Color.fromARGB(255, 212, 47, 47),
          ),
        );
        ref.read(artistSignupProvider.notifier).resetState();
      }
    });

    ref.listen(listenerSignupProvider, (prev, nxt) {
      if (nxt is ListenerSignupSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account created succesfully!"),
            backgroundColor: Color.fromARGB(255, 73, 158, 27),
          ),
        );
        Future.delayed(const Duration(milliseconds: 1500))
            .then((d) => context.go("/login"));
      } else if (nxt is ListenerSignupFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(nxt.error),
            backgroundColor: const Color.fromARGB(255, 212, 47, 47),
          ),
        );
        ref.read(listenerSignupProvider.notifier).resetState();
      }
    });
    return Scaffold(
      backgroundColor: AppColors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder<bool>(
          valueListenable: _isArtist,
          builder: (context, isArtist, _) {
            return Center(
              child: Container(
                height: deviceHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/images/uncle.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                    colorFilter: ColorFilter.mode(
                      isArtist
                          ? const Color.fromARGB(11, 0, 187, 212)
                          : const Color.fromARGB(11, 164, 53, 183),
                      BlendMode.color,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 11),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Brand(
                              text: 'Masinqo',
                              size: 50,
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              hintText: "Username",
                              controller: _usernameController,
                              isArtist: isArtist,
                              prefixIcon: Icon(
                                Icons.person,
                                color: isArtist
                                    ? AppColors.artist2
                                    : AppColors.listener4,
                              ),
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              hintText: "Email",
                              controller: _emailController,
                              isArtist: isArtist,
                              prefixIcon: Icon(
                                Icons.mail,
                                color: isArtist
                                    ? AppColors.artist2
                                    : AppColors.listener4,
                              ),
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              hintText: "Password",
                              controller: _passwordController,
                              isArtist: isArtist,
                              obscureText: true,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: isArtist
                                    ? AppColors.artist2
                                    : AppColors.listener4,
                              ),
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              hintText: "Confirm Password",
                              controller: _confirmPasswordController,
                              isArtist: isArtist,
                              obscureText: true,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: isArtist
                                    ? AppColors.artist2
                                    : AppColors.listener4,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    _isArtist.value = true;
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.transparent),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(
                                          color: isArtist
                                              ? AppColors.artist2
                                              : Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Artist Signup',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: isArtist
                                          ? AppColors.artist2
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _isArtist.value = false;
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.transparent),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(
                                          color: isArtist
                                              ? Colors.white
                                              : AppColors.listener4,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Listener Signup',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: isArtist
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255, 193, 53, 217),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: signupHandler(ref),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  isArtist
                                      ? AppColors.artist2
                                      : AppColors.listener4,
                                ),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Signup',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

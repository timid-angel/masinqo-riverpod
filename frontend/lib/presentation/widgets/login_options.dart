import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/auth/auth_providers.dart';

class LoginOptionButton extends ConsumerWidget {
  final bool isArtist;
  final Color primaryColor;
  final String buttonText;
  final bool toValue;

  const LoginOptionButton({
    super.key,
    required this.isArtist,
    required this.primaryColor,
    required this.buttonText,
    required this.toValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref.read(loginPageProvider.notifier).switchState(toValue);
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: primaryColor,
              width: 1,
            ),
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 17,
          color: primaryColor,
        ),
      ),
    );
  }
}

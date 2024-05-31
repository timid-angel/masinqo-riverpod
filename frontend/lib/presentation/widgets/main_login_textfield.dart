import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/auth/login/auth_providers.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';

class NormalLoginTextfield extends ConsumerWidget {
  final TextEditingController controller;
  final String fieldText;
  final IconData icon;
  final bool obscureText;

  const NormalLoginTextfield({
    super.key,
    required this.controller,
    required this.fieldText,
    required this.icon,
    this.obscureText = false,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginPageProvider);
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        color: AppColors.fontColor,
        fontSize: 17,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 15,
        ),
        hintStyle: const TextStyle(color: Colors.grey),
        hintText: fieldText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: loginState ? AppColors.artist2 : AppColors.listener4,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: loginState ? AppColors.artist2 : AppColors.listener4,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: loginState ? AppColors.artist2 : AppColors.listener4,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          // Icons.mail,
          icon,
          color: loginState ? AppColors.artist2 : AppColors.listener4,
        ),
      ),
    );
  }
}

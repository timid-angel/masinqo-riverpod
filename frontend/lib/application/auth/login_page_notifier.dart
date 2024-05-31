import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPageNotifier extends StateNotifier<bool> {
  LoginPageNotifier() : super(true);

  void switchState(bool toValue) {
    state = toValue;
  }
}

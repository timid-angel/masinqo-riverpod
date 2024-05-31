import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/auth/signup/signup_states.dart';
import 'package:masinqo/domain/auth/interfaces/listener_signup_respository_interface.dart';
import 'package:masinqo/domain/auth/signup/signup_entities.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_dto.dart';

class ListenerSignupNotifier extends StateNotifier<ListenerSignupState> {
  final ListenerSignupRepositoryInterface listenerSignupRepo;

  ListenerSignupNotifier({required this.listenerSignupRepo})
      : super(SignupInitialL());
  Future<void> listenerSignup(ListenerSignupDTO listenerDto) async {
    final res = await ListenerSignupEntity(
            listener: listenerDto, signupRepository: listenerSignupRepo)
        .signupListener();

    res.fold((l) {
      if (l.messages.isNotEmpty) {
        state = ListenerSignupFailure(error: l.messages[0]);
      } else {
        state = const ListenerSignupFailure(
            error: "Signup failed. Please try again");
      }
    }, (r) {
      state = ListenerSignupSuccess();
    });
  }

  void resetState() {
    state = SignupInitialL();
  }
}

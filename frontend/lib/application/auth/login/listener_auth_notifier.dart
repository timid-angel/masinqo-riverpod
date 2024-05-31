import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/auth/login/auth_state.dart';
import 'package:masinqo/domain/auth/interfaces/listener_login_repository_interface.dart';
import 'package:masinqo/domain/auth/login/login_entities.dart';
import 'package:masinqo/infrastructure/core/secure_storage_service.dart';

class ListenerAuthNotifier extends StateNotifier<ListenerAuthState> {
  final ListenerLoginRepositoryInterface listenerLoginRepo;

  ListenerAuthNotifier({required this.listenerLoginRepo})
      : super(ListenerAuthState());

  Future<void> loginListener(String email, String password) async {
    final res = await ListenerAuthEntity(
            email: email,
            password: password,
            listenerLoginRepo: listenerLoginRepo)
        .loginListener();

    await res.fold((l) {
      ListenerAuthState newState = ListenerAuthState();
      newState.errors = l.messages;
      state = newState;
    }, (r) async {
      ListenerAuthState newState = ListenerAuthState();
      await SecureStorageService().writeToken(r.token);
      newState.token = r.token;
      state = newState;
    });
  }

  void clearErrors() {
    state = ListenerAuthState();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/auth/login/auth_state.dart';
import 'package:masinqo/domain/auth/interfaces/admin_login_repository_interface.dart';
import 'package:masinqo/domain/auth/login/login_entities.dart';

class AdminAuthNotifier extends StateNotifier<AdminAuthState> {
  final AdminLoginRepositoryInterface adminLoginRepo;

  AdminAuthNotifier({required this.adminLoginRepo}) : super(AdminAuthState());

  Future<void> loginAdmin(String email, String password) async {
    state = AdminAuthState(token: "", isLoading: true);
    final res = await AdminAuthEntity(
            email: email, password: password, adminLoginRepo: adminLoginRepo)
        .loginAdmin();
    res.fold((l) {
      AdminAuthState newState = AdminAuthState(token: "");
      newState.errors = l.messages;
      state = newState;
    }, (r) {
      AdminAuthState newState = AdminAuthState(token: r.token);
      state = newState;
    });
  }

  void clearErrors() {
    state = AdminAuthState();
  }
}

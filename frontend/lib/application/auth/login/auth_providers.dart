import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/auth/login/admin_auth_notifier.dart';
import 'package:masinqo/application/auth/login/artist_auth_notifier.dart';
import 'package:masinqo/application/auth/login/auth_state.dart';
import 'package:masinqo/application/auth/login/listener_auth_notifier.dart';
import 'package:masinqo/application/auth/login/login_page_notifier.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_repository.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_repository.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_repository.dart';

final adminLoginProvider =
    StateNotifierProvider<AdminAuthNotifier, AdminAuthState>((ref) {
  return AdminAuthNotifier(adminLoginRepo: AdminLoginRepository());
});

final artistLoginProvider =
    StateNotifierProvider<ArtistAuthNotifier, ArtistAuthState>((ref) {
  return ArtistAuthNotifier(artistLoginRepo: ArtistLoginRepository());
});

final listenerLoginProvider =
    StateNotifierProvider<ListenerAuthNotifier, ListenerAuthState>((ref) {
  return ListenerAuthNotifier(listenerLoginRepo: ListenerLoginRepository());
});

final loginPageProvider = StateNotifierProvider<LoginPageNotifier, bool>((ref) {
  return LoginPageNotifier();
});

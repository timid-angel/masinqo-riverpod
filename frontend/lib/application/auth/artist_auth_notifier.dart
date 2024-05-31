import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/auth/auth_state.dart';
import 'package:masinqo/domain/auth/interfaces/artist_login_repository_interface.dart';
import 'package:masinqo/domain/auth/login/login_entities.dart';
import 'package:masinqo/infrastructure/core/secure_storage_service.dart';

class ArtistAuthNotifier extends StateNotifier<ArtistAuthState> {
  final ArtistLoginRepositoryInterface artistLoginRepo;

  ArtistAuthNotifier({required this.artistLoginRepo})
      : super(ArtistAuthState());

  Future<void> loginArtist(String email, String password) async {
    final res = await ArtistAuthEntity(
            email: email, password: password, artistLoginRepo: artistLoginRepo)
        .loginArtist();

    await res.fold((l) {
      ArtistAuthState newState = ArtistAuthState();
      newState.errors = l.messages;
      state = newState;
    }, (r) async {
      ArtistAuthState newState = ArtistAuthState();
      await SecureStorageService().writeToken(r.token);
      newState.token = r.token;
      state = newState;
    });
  }

  void clearErrors() {
    state = ArtistAuthState();
  }
}

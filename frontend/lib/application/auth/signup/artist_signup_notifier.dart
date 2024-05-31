import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/auth/signup/signup_states.dart';
import 'package:masinqo/domain/auth/interfaces/artist_signup_respository_interface.dart';
import 'package:masinqo/domain/auth/signup/signup_entities.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_dto.dart';

class ArtistSignupNotifier extends StateNotifier<ArtistSignupState> {
  final ArtistSignupRepositoryInterface artistSignupRepo;

  ArtistSignupNotifier({required this.artistSignupRepo})
      : super(SignupInitialA());
  Future<void> artistSignup(ArtistSignupDTO artistDto) async {
    final res = await ArtistSignupEntity(
            artist: artistDto, signupRepository: artistSignupRepo)
        .signupArtist();

    res.fold((l) {
      if (l.messages.isNotEmpty) {
        state = ArtistSignupFailure(error: l.messages[0]);
      } else {
        state =
            const ArtistSignupFailure(error: "Signup failed. Please try again");
      }
    }, (r) {
      state = ArtistSignupSuccess();
    });
  }

  void resetState() {
    state = SignupInitialA();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/auth/signup/artist_signup_notifier.dart';
import 'package:masinqo/application/auth/signup/listener_signup_notifier.dart';
import 'package:masinqo/application/auth/signup/signup_states.dart';
import 'package:masinqo/infrastructure/auth/signup/artist_signup_repository.dart';
import 'package:masinqo/infrastructure/auth/signup/listener_signup_repository.dart';

final artistSignupProvider =
    StateNotifierProvider<ArtistSignupNotifier, ArtistSignupState>((ref) {
  return ArtistSignupNotifier(artistSignupRepo: ArtistSignupRepository());
});

final listenerSignupProvider =
    StateNotifierProvider<ListenerSignupNotifier, ListenerSignupState>((ref) {
  return ListenerSignupNotifier(listenerSignupRepo: ListenerSignupRepository());
});

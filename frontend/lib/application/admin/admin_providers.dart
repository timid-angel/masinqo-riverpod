import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/admin/admin_artist_notifier.dart';
import 'package:masinqo/application/admin/admin_listener_notifier.dart';
import 'package:masinqo/application/admin/admin_state.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_repository.dart';
import 'package:masinqo/infrastructure/admin/admin_listeners/admin_listeners_repository.dart';

final listenerProvider = StateNotifierProvider.family<AdminListenerNotifier,
    AdminListenersState, String>((ref, token) {
  return AdminListenerNotifier(
      adminListenerRepo: AdminListenersRepository(token: token));
});

final artistProvider = StateNotifierProvider.family<AdminArtistNotifier,
    AdminArtistsState, String>((ref, token) {
  return AdminArtistNotifier(
      adminArtistRepo: AdminArtistsRepository(token: token));
});

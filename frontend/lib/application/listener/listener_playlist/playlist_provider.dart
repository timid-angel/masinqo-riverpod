import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_notifier.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
import 'package:masinqo/domain/listener/listener_playlist.dart';

final playlistRepositoryProvider = Provider<ListenerPlaylistCollection>((ref) {
  return ListenerPlaylistCollection();
});

final playlistProvider =
    StateNotifierProvider<PlaylistNotifier, PlaylistState>((ref) {
  final playlistRepository = ref.read(playlistRepositoryProvider);
  return PlaylistNotifier(playlistRepository: playlistRepository);
});

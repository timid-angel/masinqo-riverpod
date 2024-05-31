import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
import 'package:masinqo/domain/listener/listener_playlist.dart';

class PlaylistNotifier extends StateNotifier<PlaylistState> {
  final ListenerPlaylistCollection playlistRepository;

  PlaylistNotifier({required this.playlistRepository}) : super(EmptyPlaylist());

  Future<void> fetchPlaylists(String token) async {
    try {
      final playlists = await playlistRepository.getPlaylists(token);
      if (playlists.isEmpty) {
        state = EmptyPlaylist();
      } else {
        state = LoadedPlaylist(playlists);
      }
    } catch (e) {
      state = ErrorPlaylist(e.toString());
    }
  }

  // on<CreatePlaylists>((event, emit) async {
  //   // print("event name is ${event.name}");
  //   try {
  //     await playlistRepository.addPlaylist(event.name, event.token);
  //     final playlists = await playlistRepository.getPlaylists(event.token);
  //     emit(LoadedPlaylist(playlists));
  //   } catch (e) {
  //     emit(ErrorPlaylist(e.toString()));
  //   }
  // });

  Future<void> createPlaylists(String name, String token) async {
    try {
      await playlistRepository.addPlaylist(name, token);
      final playlists = await playlistRepository.getPlaylists(token);

      if (playlists.isEmpty) {
        state = EmptyPlaylist();
      } else {
        state = LoadedPlaylist(playlists);
      }
    } catch (e) {
      state = ErrorPlaylist(e.toString());
    }
  }

  Future<void> editPlaylists(String id, String name, String token) async {
    try {
      await playlistRepository.editPlaylist(id, name, token);
      final playlists = await playlistRepository.getPlaylists(token);
      state = LoadedPlaylist(playlists);
    } catch (e) {
      state = ErrorPlaylist(e.toString());
    }
  }

  Future<void> deletePlaylists(String id, String token) async {
    try {
      await playlistRepository.deletePlaylist(id, token);
      final playlists = await playlistRepository.getPlaylists(token);
      state = LoadedPlaylist(playlists);
    } catch (e) {
      state = ErrorPlaylist(e.toString());
    }
  }
}

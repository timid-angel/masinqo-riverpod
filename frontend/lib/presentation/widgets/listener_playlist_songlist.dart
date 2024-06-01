import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_provider.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/domain/entities/songs.dart';

import '../widgets/listener_playlist_songtile.dart';
import '../../temp/audio_manager/listener_audio_manager.dart';

class PlaylistTracksWidget extends ConsumerStatefulWidget {
  const PlaylistTracksWidget({
    super.key,
    required this.playlist,
    required this.token,
    required this.audioManager,
  });

  final Playlist playlist;
  final String token;
  final AudioManager audioManager;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaylistTracksWidgetState();
}

class _PlaylistTracksWidgetState extends ConsumerState<PlaylistTracksWidget> {
  @override
  Widget build(BuildContext context) {
    final playlistState = ref.watch(playlistProvider);
    Playlist currentPlaylist = widget.playlist;

    if (playlistState is LoadedPlaylist) {
      currentPlaylist = playlistState.playlists.firstWhere(
        (p) => p.id == widget.playlist.id,
        orElse: () => widget.playlist,
      );
    }
    return Column(
      children: [
        Text(
          'Tracks',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        ListView.builder(
          padding: const EdgeInsets.fromLTRB(0, 7, 0, 10),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: currentPlaylist.songs.length,
          itemBuilder: (context, idx) {
            Song song = currentPlaylist.songs[idx];
            return PlaylistSongTileWidget(
              id: currentPlaylist.id ?? "",
              song: song,
              songPath: song.filePath,
              audioManager: widget.audioManager,
              token: widget.token,
            );
          },
        ),
      ],
    );
  }
}

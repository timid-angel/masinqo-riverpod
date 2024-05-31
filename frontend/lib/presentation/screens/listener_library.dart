import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_provider.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/listener_library_playlist.dart';

class ListenerLibrary extends ConsumerWidget {
  const ListenerLibrary({
    super.key,
    // required this.playlists,
    required this.token,
  });
  final String token;
  // final List<Playlist> playlists;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistNotifier = ref.read(playlistProvider.notifier);
    final playlistState = ref.watch(playlistProvider);

    playlistNotifier.fetchPlaylists(token);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Playlists",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      final arguments = PlaylistNavigationExtras(
                        token: token,
                      );
                      context.pushNamed("listener_new_playlist",
                          extra: arguments);
                    },
                    icon: const Icon(Icons.add_circle,
                        color: AppColors.listener2),
                  ),
                ],
              ),
            ),
            Expanded(
              child: playlistState is EmptyPlaylist
                  ? const Center(child: Text('No playlists available'))
                  : playlistState is LoadedPlaylist
                      ? GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.2,
                          children: playlistState.playlists
                              .map(
                                (p) => GestureDetector(
                                  onTap: () {
                                    final arguments =
                                        PlaylistNavigationArgument(
                                      token: token,
                                      playlist: p,
                                    );
                                    context.pushNamed("listener_playlist",
                                        extra: arguments);
                                  },
                                  child: LibraryPlaylistCard(playlist: p),
                                ),
                              )
                              .toList(),
                        )
                      : playlistState is ErrorPlaylist
                          ? Center(
                              child: Text(
                                  'Failed to load playlists: ${playlistState.error}'))
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
            )
          ],
        ),
      ),
    );
  }
}

class PlaylistNavigationExtras {
  final String token;

  PlaylistNavigationExtras({required this.token});
}

class PlaylistNavigationArgument {
  final String token;
  final Playlist playlist;

  PlaylistNavigationArgument({
    required this.token,
    required this.playlist,
  });
}

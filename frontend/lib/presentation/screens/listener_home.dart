import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:masinqo/application/listener/listener_album/album_provider.dart';
import 'package:masinqo/application/listener/listener_album/album_state.dart';

import 'package:masinqo/domain/entities/albums.dart';

import 'package:masinqo/presentation/widgets/listener_home_album.dart';

class ListenerHome extends ConsumerWidget {
  const ListenerHome({
    super.key,
    required this.token,
  });
  final String token;
  // final List<Album> albums;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // BlocProvider.of<FavoriteBloc>(context).add(FetchFavorites(token: token));
    final albumNotifier = ref.read(albumProvider.notifier);
    final albumState = ref.watch(albumProvider);

    albumNotifier.fetchAlbums();

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Text(
                "Albums",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Expanded(
              child: albumState is EmptyAlbum
                  ? const Center(child: Text('No Albums available'))
                  : albumState is LoadedAlbum
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: albumState.albums.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              final arguments = AlbumNavigationArgument(
                                token: token,
                                album: albumState.albums[index],
                              );

                              context.pushNamed("listener_album",
                                  extra: arguments);
                            },
                            child: ListenerHomeAlbumCard(
                              album: albumState.albums[index],
                            ),
                          ),
                        )
                      : albumState is ErrorAlbum
                          ? Center(
                              child: Text(
                                  'Failed to load Album: ${albumState.error}'))
                          : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}

class AlbumNavigationArgument {
  final String token;
  final Album album;

  AlbumNavigationArgument({
    required this.token,
    required this.album,
  });
}

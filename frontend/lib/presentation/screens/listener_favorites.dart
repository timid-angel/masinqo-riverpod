import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_provider.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_state.dart';
import 'package:masinqo/presentation/screens/listener_home.dart';
import 'package:masinqo/presentation/widgets/listener_favorite_album.dart';

class ListenerFavorites extends ConsumerWidget {
  const ListenerFavorites({
    super.key,
    required this.token,
    // required this.favorites,
  });
  final String token;
  // final List<Album> favorites;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // BlocProvider.of<FavoriteBloc>(context).add(FetchFavorites(token: token));
    final favNotifier = ref.read(favoriteProvider.notifier);
    final favState = ref.watch(favoriteProvider);

    favNotifier.fetchFavorites(token);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Text(
                "Favorites",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Expanded(
              child: favState is EmptyFavorite
                  ? const Center(child: Text('No Favorites available'))
                  : favState is LoadedFavorite
                      ? GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.68,
                          children: favState.favorites
                              .map(
                                (a) => GestureDetector(
                                  onTap: () {
                                    final arguments = AlbumNavigationArgument(
                                      token: token,
                                      album: a,
                                    );
                                    context.pushNamed("listener_album",
                                        extra: arguments);
                                  },
                                  child: ListenerFavoriteAlbumCard(album: a),
                                ),
                              )
                              .toList(),
                        )
                      : favState is ErrorFavorite
                          ? Center(
                              child: Text(
                                  'Failed to load Favorites: ${favState.error}'))
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}

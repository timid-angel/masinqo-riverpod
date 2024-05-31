import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_notifier.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_state.dart';
import 'package:masinqo/domain/listener/listener_favorite.dart';

final favoriteRepositoryProvider = Provider<ListenerFavCollection>((ref) {
  return ListenerFavCollection();
});

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, FavoriteState>((ref) {
  final favoriteRepository = ref.read(favoriteRepositoryProvider);
  return FavoriteNotifier(favoriteRepository: favoriteRepository);
});

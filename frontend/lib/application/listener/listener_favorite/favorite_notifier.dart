import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_state.dart';
import 'package:masinqo/domain/listener/listener_favorite.dart';

class FavoriteNotifier extends StateNotifier<FavoriteState> {
  final ListenerFavCollection favoriteRepository;

  FavoriteNotifier({required this.favoriteRepository}) : super(EmptyFavorite());
  Future<void> fetchFavorites(String token) async {
    try {
      final favorites = await favoriteRepository.getFavorites(token);
      if (favorites.isEmpty) {
        state = EmptyFavorite();
      } else {
        state = LoadedFavorite(favorites);
      }
    } catch (e) {
      state = ErrorFavorite(e.toString());
    }
  }

  Future<void> addFavorite(String id, String token) async {
    try {
      await favoriteRepository.addFavorite(id, token);
      final favorites = await favoriteRepository.getFavorites(token);
      state = LoadedFavorite(favorites);
    } catch (e) {
      state = ErrorFavorite(e.toString());
    }
  }

  Future<void> deleteFavorite(String id, String token) async {
    try {
      await favoriteRepository.deleteFavorite(id, token);
      final favorites = await favoriteRepository.getFavorites(token);
      state = LoadedFavorite(favorites);
    } catch (e) {
      state = ErrorFavorite(e.toString());
    }
  }
}

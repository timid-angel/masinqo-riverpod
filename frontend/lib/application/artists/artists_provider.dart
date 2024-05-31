import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/artists/artists_album_notifier.dart';
import 'package:masinqo/application/artists/artists_create_album_notifier.dart';
import 'package:masinqo/application/artists/artists_home_page_notifier.dart';
import 'package:masinqo/application/artists/artists_state.dart';
import 'package:masinqo/infrastructure/artists/artists_repository.dart';

class AlbumProviderParamters {
  final String token;
  final String albumId;

  AlbumProviderParamters({required this.token, required this.albumId});
}

final homePageProvider = StateNotifierProvider.family<ArtistsHomePageNotifier,
    ArtistHomeState, String>((ref, token) {
  return ArtistsHomePageNotifier(artistRepo: ArtistsRepository(token: token));
});

final createAlbumProvider =
    StateNotifierProvider.family<CreateAlbumNotifier, AlbumInitial, String>(
        (ref, token) {
  return CreateAlbumNotifier(artistRepo: ArtistsRepository(token: token));
});

final albumProvider = StateNotifierProvider.family<AlbumNotifier, AlbumState,
    AlbumProviderParamters>((ref, params) {
  return AlbumNotifier(artistRepo: ArtistsRepository(token: params.token));
});

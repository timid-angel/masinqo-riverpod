import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/artists/artists_state.dart';
import 'package:masinqo/domain/artists/artists.dart';
import 'package:masinqo/domain/artists/artists_repository_interface.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

class CreateAlbumNotifier extends StateNotifier<ArtistAlbumState> {
  final ArtistsRepositoryInterface artistRepo;

  CreateAlbumNotifier({required this.artistRepo}) : super(AlbumInitial());

  Future<void> addAlbum(CreateAlbumDTO createAlbumDto) async {
    state = AlbumLoading();
    final result =
        await ArtistEntity(artistRepo: artistRepo).addAlbum(createAlbumDto);

    result.fold(
      (l) {
        state = AlbumFailure(l.message);
      },
      (r) {
        state = const AlbumSuccess('Album added successfully');
      },
    );
  }
}

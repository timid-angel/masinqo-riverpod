import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/artists/artists_state.dart';
import 'package:masinqo/domain/artists/artists.dart';
import 'package:masinqo/domain/artists/artists_repository_interface.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

class ArtistsHomePageNotifier extends StateNotifier<ArtistHomeState> {
  final ArtistsRepositoryInterface artistRepo;

  ArtistsHomePageNotifier({required this.artistRepo})
      : super(ArtistHomeState(
            name: "", email: "", profilePicture: "", albums: [])) {
    getArtistInformation();
  }

  Future<void> getArtistInformation() async {
    final res =
        await ArtistEntity(artistRepo: artistRepo).getArtistInformation();

    res.fold((l) {
      state = ArtistHomeFailureState(
          albums: state.albums,
          email: state.email,
          errorMessage: l.message,
          name: state.name,
          profilePicture: state.profilePicture);
    }, (r) {
      state = ArtistHomeState(
        name: r.name,
        email: r.email,
        profilePicture: r.profilePicture,
        albums: r.albums,
      );
    });
  }

  Future<void> updateArtistInformation(
      String profilePictureFilePath,
      String name,
      String email,
      String password,
      String confirmPassword) async {
    final res = await ArtistEntity(artistRepo: artistRepo).updateInformation(
      UpdateArtistInformatioDTO(
        profilePictureFilePath,
        name: name,
        email: email,
        password: password,
      ),
      confirmPassword,
      state.email,
    );

    res.fold((l) {
      state = ArtistHomeFailureState(
          albums: state.albums,
          email: state.email,
          errorMessage: l.message,
          name: state.name,
          profilePicture: state.profilePicture);
    }, (r) {
      state = ArtistHomeSuccessState(
        name: name,
        email: email,
        profilePicture: profilePictureFilePath,
        albums: state.albums,
      );
    });
  }

  void removeDeletedAlbums(String albumId) {
    List res = [];
    for (final album in state.albums) {
      if (album["_id"] != albumId) {
        res.add(album);
      }
    }
    state.albums = res;
  }

  void addNewAlbum(dynamic album) {
    state.albums.add(album.toJson());
  }

  void updateHomeAlbum(
      String albumId, String title, String genre, String description) {
    for (int i = 0; i < state.albums.length; i++) {
      if (albumId == state.albums[i]["_id"]) {
        state.albums[i]["title"] = title;
        state.albums[i]["genre"] = genre;
        state.albums[i]["description"] = description;
      }
    }

    state = state;
  }

  void completedEvent(ArtistHomeState errorState) {
    state = ArtistHomeState(
      name: errorState.name,
      email: errorState.email,
      profilePicture: errorState.profilePicture,
      albums: errorState.albums,
    );
  }
}

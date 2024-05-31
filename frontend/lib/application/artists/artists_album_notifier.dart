import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/artists/artists_state.dart';
import 'package:masinqo/domain/artists/artists.dart';
import 'package:masinqo/domain/artists/artists_repository_interface.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

class AlbumNotifier extends StateNotifier<AlbumState> {
  final ArtistsRepositoryInterface artistRepo;

  AlbumNotifier({required this.artistRepo})
      : super(AlbumState(
            title: "",
            albumArt: "",
            songs: [],
            description: "",
            genre: "",
            date: DateTime.now(),
            artist: "",
            error: "",
            albumId: ""));

  void initializeAlbum(AlbumState album) {
    state = album;
  }

  Future<void> addSong(String songName, String songFilePath) async {
    final res = await ArtistEntity(artistRepo: artistRepo).addSong(
      CreateSongDTO(songName: songName, albumId: state.albumId),
      songFilePath,
      state.songs,
    );

    res.fold((l) {
      state.error = l.message;
    }, (r) {
      state.songs.add(Song(name: songName, filePath: ""));
    });
  }

  Future<void> deleteSong(String albumId, String songName) async {
    final res = await ArtistEntity(artistRepo: artistRepo)
        .removeSong(albumId, songName);

    res.fold((l) {
      state.error = l.message;
    }, (r) {
      List<Song> newSongs = [];
      for (int i = 0; i < state.songs.length; i++) {
        if (state.songs[i].name != songName) {
          newSongs.add(state.songs[i]);
        }
      }
      state.songs = newSongs;
    });
  }

  Future<void> updateAlbum(
      String title, String genre, String description) async {
    final res = await ArtistEntity(artistRepo: artistRepo).updateAlbum(
      UpdateAlbumDTO(
        albumId: state.albumId,
        title: title,
        genre: genre,
        description: description,
      ),
    );

    res.fold((l) {
      state.error = l.message;
    }, (r) {
      state = AlbumState(
        title: title,
        albumArt: state.albumArt,
        artist: state.artist,
        date: state.date,
        description: description,
        error: "",
        genre: genre,
        songs: state.songs,
        albumId: state.albumId,
      );
    });
  }

  Future<void> deleteAlbum(String albumId) async {
    final res = await ArtistEntity(artistRepo: artistRepo).removeAlbum(albumId);

    res.fold((l) {
      state.error = l.message;
    }, (r) {
      state.isDeleted = true;
      // event.artistHomeBloc.add(RemoveDeletedAlbum(albumId: state.albumId));
      // event.context.goNamed("artist",
      //     pathParameters: {"token": event.artistHomeBloc.token});
    });
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/listener/listener_album/album_state.dart';

import 'package:masinqo/domain/listener/listener_album.dart';

class AlbumNotifier extends StateNotifier<AlbumState> {
  final ListenerAlbumCollection albumCollection;

  AlbumNotifier({required this.albumCollection}) : super(EmptyAlbum());

  Future<void> fetchAlbums() async {
    try {
      final albums = await albumCollection.getAlbums();
      if (albums.isEmpty) {
        state = EmptyAlbum();
      } else {
        state = LoadedAlbum(albums);
      }
    } catch (e) {
      state = ErrorAlbum(e.toString());
    }
  }
}

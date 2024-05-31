import 'package:masinqo/application/listener/listener_album/album_notifier.dart';
import 'package:masinqo/application/listener/listener_album/album_state.dart';
import 'package:masinqo/domain/listener/listener_album.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final albumCollectionProvider = Provider<ListenerAlbumCollection>((ref) {
  return ListenerAlbumCollection();
});

final albumProvider = StateNotifierProvider<AlbumNotifier, AlbumState>((ref) {
  final albumCollection = ref.read(albumCollectionProvider);
  return AlbumNotifier(albumCollection: albumCollection);
});

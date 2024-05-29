import 'package:masinqo/temp/models/albums.dart';
import 'package:masinqo/temp/models/playlist.dart';

class ListenerHomePageData {
  ListenerHomePageData(
      {required this.albums,
      required this.favorites,
      required this.playlists,
      required this.token});

  final List<Album> albums;
  final List<Album> favorites;
  final List<Playlist> playlists;
  final String token;
}

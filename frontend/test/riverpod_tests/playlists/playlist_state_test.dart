import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';

void main() {
  group('PlaylistState Test', () {
    test('EmptyPlaylist should be an instance of PlaylistState', () {
      expect(EmptyPlaylist(), isA<PlaylistState>());
    });

    test('LoadedPlaylist should be an instance of PlaylistState', () {
      expect(LoadedPlaylist([]), isA<PlaylistState>());
    });

    test('ErrorPlaylist should be an instance of PlaylistState', () {
      expect(ErrorPlaylist('error'), isA<PlaylistState>());
    });
  });
}

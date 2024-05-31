import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_events.dart';

void main() {
  group('PlaylistEvent', () {
    test('FetchPlaylists should have correct properties', () {
      final event = FetchPlaylists(token: 'testToken');
      expect(event.token, 'testToken');
    });

    test('CreatePlaylists should have correct properties', () {
      final event = CreatePlaylists(token: 'testToken', name: 'testName');
      expect(event.token, 'testToken');
      expect(event.name, 'testName');
    });

    test('EditPlaylists should have correct properties', () {
      final event =
          EditPlaylists(token: 'testToken', id: 'testId', name: 'testName');
      expect(event.token, 'testToken');
      expect(event.id, 'testId');
      expect(event.name, 'testName');
    });

    test('DeletePlaylists should have correct properties', () {
      final event = DeletePlaylists(token: 'testToken', id: 'testId');
      expect(event.token, 'testToken');
      expect(event.id, 'testId');
    });
  });
}

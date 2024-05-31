import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/artists/artists_events.dart';
import 'package:masinqo/application/artists/artists_state.dart';
import 'package:masinqo/domain/entities/albums.dart';

void main() {
  group('HomeAlbumUpdateEvent', () {
    test('should take in albumId, title, genre, and description', () {
      const event = HomeAlbumUpdateEvent(
        albumId: '1',
        title: 'Test Title',
        genre: 'Test Genre',
        description: 'Test Description',
      );

      expect(event.albumId, '1');
      expect(event.title, 'Test Title');
      expect(event.genre, 'Test Genre');
      expect(event.description, 'Test Description');
    });
  });

  group('CompletedEvent', () {
    test('should take in errorState', () {
      final errorState = ArtistHomeState(
        name: 'Test Name',
        email: 'Test Email',
        profilePicture: 'Test Profile Picture',
        albums: [],
      );
      final event = CompletedEvent(errorState: errorState);

      expect(event.errorState, errorState);
    });
  });

  group('CreateNewAlbum', () {
    test('should take in album', () {
      final album = Album(
        id: '1',
        title: 'Test Title',
        albumArt: 'Test Album Art',
        songs: [],
        description: 'Test Description',
        genre: 'Test Genre',
        date: DateTime.now(),
        artist: 'Test Artist',
      );

      final event = CreateNewAlbum(album: album);

      expect(event.album, album);
    });
  });
}

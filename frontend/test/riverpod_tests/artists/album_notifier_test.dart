import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/artists/artists_album_notifier.dart';
import 'package:masinqo/application/artists/artists_state.dart';
import 'package:masinqo/domain/artists/artists_repository_interface.dart';
import 'package:mockito/mockito.dart';

class MockArtistsRepository extends Mock
    implements ArtistsRepositoryInterface {}

void main() {
  group('AlbumNotifier', () {
    late AlbumNotifier albumNotifier;
    late MockArtistsRepository mockArtistsRepository;

    setUp(() {
      mockArtistsRepository = MockArtistsRepository();
      albumNotifier = AlbumNotifier(artistRepo: mockArtistsRepository);
    });

    test('should initialize album', () {
      final album = AlbumState(
        title: "Test",
        albumArt: "Test",
        songs: [],
        description: "Test",
        genre: "Test",
        date: DateTime.now(),
        artist: "Test",
        error: "",
        albumId: "Test",
      );

      albumNotifier.initializeAlbum(album);

      expect(albumNotifier.state, equals(album));
    });

    // Add more tests for other methods in the AlbumNotifier class
  });
}

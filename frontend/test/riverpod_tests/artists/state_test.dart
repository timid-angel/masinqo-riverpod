import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/artists/artists_state.dart';

void main() {
  group('Song', () {
    final song = Song(name: 'Test Song', filePath: 'path/to/song');

    test('should have correct properties', () {
      expect(song.name, 'Test Song');
      expect(song.filePath, 'path/to/song');
    });
  });
}

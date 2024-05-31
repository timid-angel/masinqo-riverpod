import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/application/artists/artists_state.dart';
import 'package:masinqo/presentation/widgets/artist_album_card.dart';

void main() {
  testWidgets("Artist Album Card test", (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AlbumCard(
            album: AlbumState(
                title: "test_title",
                description: "test_desc",
                genre: "test_genre",
                date: DateTime.now(),
                albumArt: "",
                songs: [],
                artist: '',
                error: '',
                albumId: ''),
          ),
        ),
      ),
    );

    final titleFinder = find.text("test_title");
    final genreFinder = find.text("test_genre");
    final descFinder = find.text("test_desc");

    expect(titleFinder, findsOneWidget);
    expect(genreFinder, findsOneWidget);
    expect(descFinder, findsOneWidget);
  });
}

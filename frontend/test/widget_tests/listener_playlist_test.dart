import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/presentation/screens/listener_playlist.dart';
import 'package:masinqo/presentation/widgets/listener_appbar.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_albumart.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_buttons.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_headline.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_songlist.dart';
import 'http_override.dart';

void main() {
  testWidgets('Listener Playlist Test', (tester) async {
    HttpOverrides.global = MyHttpOverrides();
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: PlaylistWidget(
            playlist: Playlist(
              name: 'test_pl',
              creationDate: DateTime.now(),
              description: "test_desc",
              owner: "test_owner",
              songs: [],
              id: '',
            ),
            token: '',
          ),
        ),
      ),
    );

    expect(find.byType(NestedScrollView), findsOneWidget);
    expect(find.byType(ListenerAppbar), findsOneWidget);
    expect(find.byType(Stack), findsExactly(2));
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(PlaylistAlbumArt), findsOneWidget);
    expect(find.byType(PlaylistHeadlineWidget), findsOneWidget);
    expect(find.byType(PlaylistButtonsWidget), findsOneWidget);
    expect(find.byType(PlaylistTracksWidget), findsOneWidget);
    expect(find.text("test_pl"), findsOneWidget);
  });
}

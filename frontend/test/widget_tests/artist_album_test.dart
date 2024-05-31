import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/screens/artist_album.dart';
import 'package:masinqo/presentation/widgets/artist_add_song_modal.dart';
import 'package:masinqo/presentation/widgets/artist_edit_album_modal.dart';
import 'package:masinqo/presentation/widgets/delete_confirmation_modal.dart';

import 'http_override.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  group("Artist Album Page", () {
    testWidgets('Page and Add Button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ArtistsAlbumPage(
              albumId: '',
            ),
          ),
        ),
      );

      expect(find.text('Add Song'), findsOneWidget);
      expect(find.text('Edit Album'), findsOneWidget);
      expect(find.text('Delete Album'), findsOneWidget);
      expect(find.text('Tracks'), findsOneWidget);

      final addSongButton = find.text('Add Song');
      await tester.tap(addSongButton);
      await tester.pump();
      expect(find.byType(AddSongModal), findsOneWidget);
    });

    testWidgets('Edit Button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ArtistsAlbumPage(
              albumId: '',
            ),
          ),
        ),
      );
      final editAlbumButton = find.text('Edit Album');
      await tester.tap(editAlbumButton);
      await tester.pump();
      expect(find.byType(EditSongModal), findsOneWidget);
    });

    testWidgets('Delete Button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ArtistsAlbumPage(
              albumId: '',
            ),
          ),
        ),
      );

      final deleteAlbumButton = find.text('Delete Album');
      await tester.tap(deleteAlbumButton);
      await tester.pump();
      expect(find.byType(DeleteConfirmationDialog), findsOneWidget);
    });
  });
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/artist_drawer.dart';
import 'package:masinqo/presentation/widgets/listener_drawer.dart';

import 'http_override.dart';

void main() {
  group("Drawers Test", () {
    testWidgets("Artist Drawer Test", (tester) async {
      HttpOverrides.global = MyHttpOverrides();
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: ArtistDrawer()),
          ),
        ),
      );

      final profilemgmtFinder = find.text('Profile Management');
      final logoutFinder = find.text('Logout');
      final avatarFinder = find.byType(CircleAvatar);

      expect(profilemgmtFinder, findsOneWidget);
      expect(logoutFinder, findsOneWidget);
      expect(avatarFinder, findsOneWidget);
    });

    testWidgets("Listener Drawer Test", (tester) async {
      HttpOverrides.global = MyHttpOverrides();
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
                body: ListenerDrawer(
              token: '',
            )),
          ),
        ),
      );

      final profilemgmtFinder = find.text('Profile Management');
      final logoutFinder = find.text('Logout');
      final avatarFinder = find.byType(CircleAvatar);

      expect(profilemgmtFinder, findsOneWidget);
      expect(logoutFinder, findsOneWidget);
      expect(avatarFinder, findsOneWidget);
    });
  });
}

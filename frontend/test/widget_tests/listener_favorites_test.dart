import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/screens/listener_favorites.dart';

import 'http_override.dart';

void main() {
  testWidgets('Listener Favorites Test', (WidgetTester tester) async {
    HttpOverrides.global = MyHttpOverrides();
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ListenerFavorites(token: ""),
        ),
      ),
    );

    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text("No Favorites available"), findsOneWidget);
  });
}

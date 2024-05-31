import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/screens/listener_library.dart';
import 'http_override.dart';

void main() {
  testWidgets('Listener Library Test', (tester) async {
    HttpOverrides.global = MyHttpOverrides();
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ListenerLibrary(token: ""),
        ),
      ),
    );

    expect(find.text('Playlists'), findsOneWidget);
    expect(find.byIcon(Icons.add_circle), findsOneWidget);
  });
}

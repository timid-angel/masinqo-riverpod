import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/screens/listener_home.dart';
import 'http_override.dart';

void main() {
  testWidgets("Listener Home Test", (tester) async {
    HttpOverrides.global = MyHttpOverrides();
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: const ListenerHome(
              token: '',
            ),
          ),
        ),
      ),
    );

    expect(find.text("Albums"), findsOneWidget);
    expect(find.text("No Albums available"), findsOneWidget);
  });
}

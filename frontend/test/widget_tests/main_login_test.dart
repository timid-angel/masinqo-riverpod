import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/screens/login.dart';
import 'package:masinqo/presentation/widgets/background.dart';
import 'package:masinqo/presentation/widgets/login_options.dart';

import 'http_override.dart';

void main() {
  testWidgets("Main Login Page Test", (tester) async {
    HttpOverrides.global = MyHttpOverrides();
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        home: Scaffold(body: LoginWidget()),
      ),
    ));

    final loginArtistBtn = find.text('Login as Artist');
    final loginListenerBtn = find.text('Login as Listener');
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(BackgroundGradient), findsOneWidget);
    expect(find.text('Admin'), findsOneWidget);
    expect(find.text('Masinqo'), findsOneWidget);
    expect(find.text("Artist Email"), findsOneWidget);
    expect(find.text("Password"), findsOneWidget);
    expect(find.byType(LoginOptionButton), findsExactly(2));
    expect(loginArtistBtn, findsOneWidget);
    expect(loginListenerBtn, findsOneWidget);

    await tester.tap(loginListenerBtn);
    await tester.pump();
    expect(find.text("User Email"), findsOneWidget);

    await tester.tap(loginArtistBtn);
    await tester.pump();
    expect(find.text("Artist Email"), findsOneWidget);
  });
}

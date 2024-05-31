import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masinqo/presentation/widgets/listener_album_albumart.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'http_override.dart';

@GenerateMocks([http.Client])
void main() {
  testWidgets("Album Art Widget Test", (tester) async {
    HttpOverrides.global = MyHttpOverrides();

    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
      body: AlbumArt(deviceWidth: 100, albumArt: "a"),
    )));

    expect(find.byType(Container), findsOneWidget);
    // expect(find.image(const AssetImage("assets/images/black.png")),
    //     findsOneWidget);
  });
}

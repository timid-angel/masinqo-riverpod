// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:masinqo/domain/entities/albums.dart';
// import 'package:masinqo/presentation/widgets/listener_album_headline.dart';
// import 'http_override.dart';

// void main() {
//   testWidgets("Listener Album Headline", (tester) async {
//     HttpOverrides.global = MyHttpOverrides();
//     await tester.pumpWidget(
//       ProviderScope(
//         child: MaterialApp(
//           home: AlbumHeadlineWidget(
//             album: Album(
//               title: "testing_title",
//               description: "test_desciption",
//               genre: "test_genre",
//               date: DateTime.now(),
//               albumArt: "",
//               artist: "",
//               songs: [],
//               id: '',
//             ),
//             token: '',
//           ),
//         ),
//       ),
//     );

//     expect(find.byIcon(Icons.favorite), findsOneWidget);
//     await tester.tap(find.byType(GestureDetector));
//     await tester.pump();
//     expect(find.byIcon(Icons.favorite_border_outlined), findsOneWidget);
//   });
// }

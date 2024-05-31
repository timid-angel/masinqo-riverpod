// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:riverpod/riverpod.dart';
// import 'package:masinqo/application/artists/artists_provider.dart';
// import 'package:masinqo/application/artists/artists_home_page_notifier.dart';
// import 'package:masinqo/application/artists/artists_create_album_notifier.dart';

// class MockArtistsRepository extends Mock implements ArtistsRepository {}

// void main() {
//   group('ArtistsProvider Test', () {
//     test('HomePageProvider Test', () {
//       final artistRepo = MockArtistsRepository();
//       final provider = homePageProvider('test_token');
//       final container = ProviderContainer(overrides: [
//         provider.overrideWithProvider(
//           StateNotifierProvider(
//               (ref) => ArtistsHomePageNotifier(artistRepo: artistRepo)),
//         ),
//       ]);
//     });

//     test('CreateAlbumProvider Test', () {
//       final artistRepo = MockArtistsRepository();
//       final provider = createAlbumProvider('test_token');
//       final container = ProviderContainer(overrides: [
//         provider.overrideWithProvider(
//           StateNotifierProvider(
//               (ref) => CreateAlbumNotifier(artistRepo: artistRepo)),
//         ),
//       ]);

//       // Add your assertions here
//     });

//     test('AlbumProvider Test', () {
//       final artistRepo = MockArtistsRepository();
//       final provider = albumProvider(
//           AlbumProviderParamters(token: 'test_token', albumId: 'test_albumId'));
//       final container = ProviderContainer(overrides: [
//         provider.overrideWithProvider(
//           StateNotifierProvider((ref) => AlbumNotifier(artistRepo: artistRepo)),
//         ),
//       ]);

//       // Add your assertions here
//     });
//   });
// }

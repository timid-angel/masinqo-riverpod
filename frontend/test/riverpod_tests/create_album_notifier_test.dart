// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:masinqo/application/artists/artists_state.dart';
// import 'package:masinqo/application/artists/artists_provider.dart';
// import 'package:masinqo/infrastructure/artists/artists_dto.dart';

// void main() {
//   test('CreateAlbumNotifier test', () async {
//     final container = ProviderContainer();
//     final notifier = container.read(createAlbumProvider('testToken'));

//     expect(notifier.state, isA<AlbumInitial>());

//     await notifier.addAlbum(CreateAlbumDTO(
//       title: 'testTitle',
//       genre: 'testGenre',
//       description: 'testDescription',
//       albumArt: 'testAlbumArt',
//       type: 'testType',
//     ));

//     expect(notifier.state, isA<AlbumLoading>());
//   });
// }

// import 'package:flutter_test/flutter_test.dart';
// import 'package:masinqo/infrastructure/auth/artist/artist_login_repository.dart';
// import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart';
// import 'package:masinqo/infrastructure/auth/login_failure.dart';
// import 'package:masinqo/infrastructure/auth/login_success.dart';
// import 'package:mockito/mockito.dart';
// import 'package:masinqo/infrastructure/auth/artist/artists_create_album_notifier.dart';

// class MockArtistLoginRepository extends Mock implements ArtistLoginRepository {}

// void main() {
//   ArtistsCreateAlbumNotifier notifier;
//   MockArtistLoginRepository mockArtistLoginRepository;

//   setUp(() {
//     mockArtistLoginRepository = MockArtistLoginRepository();
//     notifier = ArtistsCreateAlbumNotifier(mockArtistLoginRepository);
//   });

//   group('ArtistsCreateAlbumNotifier', () {
//     test('should return success when album creation is successful', () async {
//       when(mockArtistLoginRepository.createAlbum(any))
//           .thenAnswer((_) async => Right(LoginSuccess()));

//       await notifier.createAlbum(ArtistLoginDto());

//       expect(notifier.state, equals(LoginSuccess()));
//     });

//     test('should return failure when album creation fails', () async {
//       when(mockArtistLoginRepository.createAlbum(any))
//           .thenAnswer((_) async => Left(LoginFailure()));

//       await notifier.createAlbum(ArtistLoginDto());

//       expect(notifier.state, equals(LoginFailure()));
//     });
//   });
// }

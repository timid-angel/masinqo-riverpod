// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:dartz/dartz.dart';
// import 'package:masinqo/application/artists/artists_state.dart';
// import 'package:masinqo/domain/artists/artists_repository_interface.dart';
// import 'package:masinqo/domain/entities/albums.dart';
// import 'package:masinqo/infrastructure/artists/artists_dto.dart';
// import 'package:masinqo/application/artists/artists_home_page_notifier.dart';
// import 'package:masinqo/core.dart';

// // Mock class for ArtistsRepositoryInterface
// class MockArtistsRepository extends Mock
//     implements ArtistsRepositoryInterface {}

// void main() {
//   late ArtistsHomePageNotifier notifier;
//   late MockArtistsRepository mockRepository;

//   setUp(() {
//     mockRepository = MockArtistsRepository();
//     notifier = ArtistsHomePageNotifier(artistRepo: mockRepository);
//   });

//   group('ArtistsHomePageNotifier Tests', () {
//     test('Initial state is correct', () {
//       expect(
//         notifier.state,
//         isA<ArtistHomeState>()
//             .having((s) => s.name, 'name', '')
//             .having((s) => s.email, 'email', '')
//             .having((s) => s.profilePicture, 'profilePicture', '')
//             .having((s) => s.albums, 'albums', isEmpty),
//       );
//     });

//     test('getArtistInformation updates state on success', () async {
//       // Arrange
//       final artistData = ArtistEntity(
//           name: "John Doe",
//           email: "john@example.com",
//           profilePicture: "profile.jpg",
//           albums: []);
//       when(mockRepository.getArtistInformation())
//           .thenAnswer((_) async => Right(artistData));

//       await notifier.getArtistInformation();

//       expect(
//         notifier.state,
//         isA<ArtistHomeState>()
//             .having((s) => s.name, 'name', 'John Doe')
//             .having((s) => s.email, 'email', 'john@example.com')
//             .having((s) => s.profilePicture, 'profilePicture', 'profile.jpg')
//             .having((s) => s.albums, 'albums', isEmpty),
//       );
//     });

//     test('getArtistInformation updates state on failure', () async {
//       // Arrange
//       when(mockRepository.getArtistInformation())
//           .thenAnswer((_) async => Left(Failure()));

//       // Act
//       await notifier.getArtistInformation();

//       // Assert
//       expect(
//         notifier.state,
//         isA<ArtistHomeFailureState>()
//             .having((s) => s.errorMessage, 'errorMessage',
//                 'Failed to load artist information')
//             .having((s) => s.albums, 'albums', isEmpty),
//       );
//     });

//     test('updateArtistInformation updates state on success', () async {
//       // Arrange
//       final updateDTO = UpdateArtistInformatioDTO("new_profile.jpg",
//           name: "Jane Doe", email: "jane@example.com", password: "password123");
//       when(mockRepository.updateInformation(any, any, any))
//           .thenAnswer((_) async => Right(null));

//       // Act
//       await notifier.updateArtistInformation("new_profile.jpg", "Jane Doe",
//           "jane@example.com", "password123", "password123");

//       // Assert
//       expect(
//         notifier.state,
//         isA<ArtistHomeSuccessState>()
//             .having((s) => s.name, 'name', 'Jane Doe')
//             .having((s) => s.email, 'email', 'jane@example.com')
//             .having(
//                 (s) => s.profilePicture, 'profilePicture', 'new_profile.jpg'),
//       );
//     });

//     test('updateArtistInformation updates state on failure', () async {
//       when(mockRepository.updateInformation(any, any, any)).thenAnswer(
//           (_) async => Left(Failure("Failed to update artist information")));

//       await notifier.updateArtistInformation("new_profile.jpg", "Jane Doe",
//           "jane@example.com", "password123", "password123");

//       expect(
//         notifier.state,
//         isA<ArtistHomeFailureState>().having((s) => s.errorMessage,
//             'errorMessage', 'Failed to update artist information'),
//       );
//     });

//     test('removeDeletedAlbums removes album by ID', () {
//       // Arrange
//       notifier.state = ArtistHomeState(
//         name: "John Doe",
//         email: "john@example.com",
//         profilePicture: "profile.jpg",
//         albums: [
//           {"_id": "1", "title": "Album 1"},
//           {"_id": "2", "title": "Album 2"}
//         ],
//       );

//       // Act
//       notifier.removeDeletedAlbums("1");

//       // Assert
//       expect(notifier.state.albums, hasLength(1));
//       expect(notifier.state.albums[0]["_id"], "2");
//     });

//     test('addNewAlbum adds album to state', () {
//       final newAlbum = Album(
//         id: "3",
//         title: "Album 3, New",
//       ).toJson();

//       notifier.addNewAlbum(newAlbum);

//       // Assert
//       expect(notifier.state.albums, hasLength(1));
//       expect(notifier.state.albums[0]["_id"], "3");
//       expect(notifier.state.albums[0]["title"], "Album 3");
//     });

//     test('updateHomeAlbum updates album details', () {
//       // Arrange
//       notifier.state = ArtistHomeState(
//         name: "John Doe",
//         email: "john@example.com",
//         profilePicture: "profile.jpg",
//         albums: [
//           {
//             "_id": "1",
//             "title": "Album 1",
//             "genre": "Rock",
//             "description": "Desc 1"
//           },
//           {
//             "_id": "2",
//             "title": "Album 2",
//             "genre": "Pop",
//             "description": "Desc 2"
//           }
//         ],
//       );

//       // Act
//       notifier.updateHomeAlbum(
//           "1", "New Title", "New Genre", "New Description");

//       // Assert
//       expect(notifier.state.albums[0]["title"], "New Title");
//       expect(notifier.state.albums[0]["genre"], "New Genre");
//       expect(notifier.state.albums[0]["description"], "New Description");
//     });

//     test('completedEvent sets state correctly', () {
//       // Arrange
//       final newState = ArtistHomeState(
//         name: "New Name",
//         email: "new@example.com",
//         profilePicture: "new_profile.jpg",
//         albums: [
//           {"_id": "3", "title": "Album 3"}
//         ],
//       );

//       // Act
//       notifier.completedEvent(newState);

//       // Assert
//       expect(
//         notifier.state,
//         isA<ArtistHomeState>()
//             .having((s) => s.name, 'name', 'New Name')
//             .having((s) => s.email, 'email', 'new@example.com')
//             .having(
//                 (s) => s.profilePicture, 'profilePicture', 'new_profile.jpg')
//             .having((s) => s.albums, 'albums', hasLength(1)),
//       );
//     });
//   });
// }

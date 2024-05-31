// import 'package:flutter_test/flutter_test.dart';
// import 'package:masinqo/application/listener/listener_playlist/playlist_notifier.dart';
// import 'package:masinqo/application/listener/listener_playlist/playlist_state.dart';
// import 'package:masinqo/domain/listener/listener_playlist.dart';
// import 'package:mockito/mockito.dart';
// import 'package:masinqo/domain/entities/playlist.dart';

// class MockListenerPlaylistCollection extends Mock
//     implements ListenerPlaylistCollection {}

// void main() {
//   group('PlaylistNotifier', () {
//     late PlaylistNotifier playlistNotifier;
//     late MockListenerPlaylistCollection mockPlaylistRepository;

//     setUp(() {
//       mockPlaylistRepository = MockListenerPlaylistCollection();
//       playlistNotifier =
//           PlaylistNotifier(playlistRepository: mockPlaylistRepository);
//     });

//     test(
//         'fetchPlaylists should update state to LoadedPlaylist when playlists are fetched successfully',
//         () async {
//       when(mockPlaylistRepository.getPlaylists('testToken'))
//           .thenAnswer((_) async => Future.value([
//                 Playlist(
//                     id: '1',
//                     name: 'Test',
//                     songs: [],
//                     creationDate: DateTime.now(),
//                     owner: '',
//                     description: '')
//               ]));

//       await playlistNotifier.fetchPlaylists('testToken');

//       expect(playlistNotifier.state, isA<LoadedPlaylist>());
//     });

//     test(
//         'fetchPlaylists should update state to ErrorPlaylist when an error occurs',
//         () async {
//       when(mockPlaylistRepository.getPlaylists('testToken'))
//           .thenThrow(Exception('Failed to fetch playlists'));

//       await playlistNotifier.fetchPlaylists('testToken');

//       expect(playlistNotifier.state, isA<ErrorPlaylist>());
//     });
//   });
// }

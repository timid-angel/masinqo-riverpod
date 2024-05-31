import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/artists/artists_provider.dart';
import 'package:masinqo/application/artists/artists_state.dart';
import 'package:masinqo/application/auth/login/auth_providers.dart';
import 'package:masinqo/presentation/widgets/artist_album_card.dart';
import 'package:masinqo/presentation/widgets/artist_app_bar.dart';
import 'package:masinqo/presentation/widgets/artist_create_album_modal.dart';
import 'package:masinqo/presentation/widgets/artist_drawer.dart';
import 'package:masinqo/presentation/widgets/artist_profile_section.dart';

class ArtistHomePage extends ConsumerWidget {
  final String token;
  ArtistHomePage({super.key, required this.token});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = homePageProvider(ref.read(artistLoginProvider).token);
    final homePageState = ref.read(provider);
    return Scaffold(
      key: _scaffoldKey,
      appBar: ArtistAppBar(scaffoldKey: _scaffoldKey),
      backgroundColor: Colors.black,
      endDrawer: const ArtistDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ArtistProfileSection(
              artistName: homePageState.name,
              profilePicture: homePageState.profilePicture.isNotEmpty
                  ? homePageState.profilePicture
                  : "local/artist_placeholder.jpg",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Builder(builder: (context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.add_circle,
                        color: Color(0xFF39DCF3),
                        size: 30,
                      ),
                      onPressed: () {
                        showModal(context, token);
                      },
                    );
                  }),
                  const Text(
                    'Create Album',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: homePageState.albums.map(
                (album) {
                  final List<Song> songs = [];
                  for (final song in album["songs"]) {
                    final Song currSong =
                        Song(filePath: song["filePath"], name: song["name"]);
                    songs.add(currSong);
                  }

                  return AlbumCard(
                    album: AlbumState(
                        title: album["title"],
                        description: album["description"],
                        genre: album["genre"],
                        date: DateTime.parse(album["date"]),
                        albumArt: album["albumArtPath"] ??
                            "local/album_art_placeholder.jpg",
                        artist: homePageState.name,
                        songs: songs,
                        error: '',
                        albumId: album["_id"]),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void showModal(BuildContext context, String token) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateAlbumModal(
          token: token,
        );
      },
    );
  }
}

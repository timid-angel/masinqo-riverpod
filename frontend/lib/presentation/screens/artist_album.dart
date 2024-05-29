import 'package:flutter/material.dart';
import 'package:masinqo/temp/models/albums.dart';
import '../widgets/artist_add_song_modal.dart';
import '../widgets/artist_edit_album_modal.dart';
import '../widgets/artist_drawer.dart';
import '../widgets/artist_app_bar.dart';
import '../widgets/artist_song_card.dart';
import '../widgets/delete_confirmation_modal.dart';
import '../../temp/audio_manager/artist_audio_manager.dart';

class ArtistsAlbumPage extends StatefulWidget {
  final Album album;

  const ArtistsAlbumPage({
    super.key,
    required this.album,
  });

  @override
  ArtistsAlbumPageState createState() => ArtistsAlbumPageState();
}

class ArtistsAlbumPageState extends State<ArtistsAlbumPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AudioManager _audioManager;

  @override
  void initState() {
    super.initState();
    _audioManager = AudioManager();
  }

  @override
  void dispose() {
    _audioManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: ArtistAppBar(scaffoldKey: _scaffoldKey),
      endDrawer: const ArtistDrawer(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.album.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    '${widget.album.songs.length} Tracks',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: const Color(0xFF39DCF3), width: 1.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  children: [
                    Image.asset(
                      widget.album.albumArt,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned(
                      bottom: 10.0,
                      right: 10.0,
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF39DCF3),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AddSongModal();
                          },
                        );
                      },
                      icon: const Icon(Icons.add_circle),
                      label: const Text(
                        'Add Song',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all<Color>(
                            const Color(0xFF39DCF3)),
                        shape: WidgetStateProperty.all<OutlinedBorder>(
                          const CircleBorder(),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EditSongModal(
                              currentAlbumName: widget.album.albumArt,
                              currentGenre: widget.album.genre,
                              currentDescription: widget.album.description,
                              currentThumbnailPath: widget.album.albumArt,
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text(
                        'Edit Album',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all<Color>(
                            const Color(0xFF39DCF3)),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteConfirmationDialog(
                              title:
                                  'Are you sure you want to delete this album?',
                              onConfirm: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text(
                        'Delete Album',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      style: ButtonStyle(
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Tracks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.album.songs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: SongCard(
                    audioManager: _audioManager,
                    songNumber: index + 1,
                    songName: widget.album.songs[index].name,
                    artistName: widget.album.songs[index].album.artist.name,
                    imagePath: widget.album.albumArt,
                    songFilePath: widget.album.songs[index].filePath,
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

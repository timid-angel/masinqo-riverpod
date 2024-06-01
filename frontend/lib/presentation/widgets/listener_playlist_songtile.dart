import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_provider.dart';
import 'package:masinqo/domain/entities/songs.dart';
import 'package:masinqo/infrastructure/core/url.dart';

import '../../temp/audio_manager/listener_audio_manager.dart';

class PlaylistSongTileWidget extends ConsumerWidget {
  const PlaylistSongTileWidget({
    super.key,
    required this.id,
    required this.song,
    required this.audioManager,
    required this.songPath,
    required this.token,
  });

  final Song song;
  final String id;
  final String token;
  final String songPath;
  final AudioManager audioManager;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        audioManager.stop();
        audioManager.play(song.filePath);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: deviceWidth * 0.14,
                  height: deviceWidth * 0.14,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(song.albumArt.isNotEmpty
                          ? "${Domain.url}/${song.albumArt}"
                          : "${Domain.url}/local/album_art_placeholder.jpg"),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: deviceWidth * 0.5,
                      child: Text(
                        song.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth * 0.52,
                      child: Text(
                        song.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle_outline,
                  color: Color.fromARGB(255, 237, 86, 84)),
              onPressed: () {
                ref
                    .read(playlistProvider.notifier)
                    .deleteSongFromPlaylist(id, "", token, 1, "", songPath);
              },
            )
          ],
        ),
      ),
    );
  }
}

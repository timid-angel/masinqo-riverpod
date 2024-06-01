import 'package:flutter/material.dart';
import 'package:masinqo/domain/entities/playlist.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';

import 'package:masinqo/presentation/widgets/listener_appbar.dart';
import 'package:masinqo/presentation/widgets/listener_drawer.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_albumart.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_buttons.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_headline.dart';
import 'package:masinqo/presentation/widgets/listener_playlist_songlist.dart';
import '../../temp/audio_manager/listener_audio_manager.dart';

class PlaylistWidget extends StatelessWidget {
  final Playlist playlist;
  final String token;

  const PlaylistWidget({
    super.key,
    required this.token,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    final AudioManager audioManager = AudioManager();
    // print("here to check playist");
    // print(widget.playlist.id);
    // BlocProvider.of<PlaylistBloc>(context).add(FetchPlaylists(token: token));
    return Scaffold(
      backgroundColor: AppColors.black,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) {
          return [
            const ListenerAppbar(),
          ];
        },
        body: Stack(
          children: [
            Container(
              width: deviceWidth,
              height: deviceHeight,
              decoration: const BoxDecoration(
                  gradient: AppColors.slantedPurpleGradient),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  PlaylistAlbumArt(
                      deviceWidth: deviceWidth, playlist: playlist),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                    child: Column(
                      children: [
                        PlaylistHeadlineWidget(playlist: playlist),
                        PlaylistButtonsWidget(
                          editController: () {},
                          deleteController: () {},
                          playlistName: playlist.name,
                          token: token,
                          id: playlist.id ?? "",
                        ),
                        const Divider(height: 30, thickness: 2),
                        PlaylistTracksWidget(
                          playlist: playlist,
                          token: token,
                          audioManager: audioManager,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: ListenerDrawer(
        token: token,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';

import 'package:masinqo/presentation/widgets/listener_album_albumart.dart';
import 'package:masinqo/presentation/widgets/listener_album_headline.dart';
import 'package:masinqo/presentation/widgets/listener_album_songlist.dart';
import 'package:masinqo/presentation/widgets/listener_appbar.dart';
import 'package:masinqo/presentation/widgets/listener_drawer.dart';
import '../../domain/entities/albums.dart';
import '../../temp/audio_manager/listener_audio_manager.dart';

class AlbumWidget extends ConsumerStatefulWidget {
  final Album album;
  final String token;

  const AlbumWidget({
    super.key,
    required this.album,
    required this.token,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlbumWidgetState();
}

class _AlbumWidgetState extends ConsumerState<AlbumWidget> {
  late AudioManager audioManager;

  @override
  void initState() {
    super.initState();
    audioManager = AudioManager();
  }

  @override
  void dispose() {
    audioManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

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
                  AlbumArt(
                      deviceWidth: deviceWidth,
                      albumArt: widget.album.albumArt),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        AlbumHeadlineWidget(
                            album: widget.album, token: widget.token),
                        const Divider(height: 30, thickness: 2),
                        AlbumTracksWidget(
                            token: widget.token,
                            album: widget.album,
                            onAdd: () {},
                            audioManager: audioManager),
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
        token: widget.token,
      ),
    );
  }
}


// class PlaylistNavigationArgument {
//   final String token;
//   final Playlist playlist;
//   final PlaylistBloc playlistBloc;

//   PlaylistNavigationArgument(
//       {required this.token,
//       required this.playlist,
//       required this.playlistBloc});
// }
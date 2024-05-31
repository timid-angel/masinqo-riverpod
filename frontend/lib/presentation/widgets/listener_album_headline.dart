import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_provider.dart';
import 'package:masinqo/application/listener/listener_favorite/favorite_state.dart';
import 'package:masinqo/domain/entities/albums.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';

class AlbumHeadlineWidget extends ConsumerStatefulWidget {
  const AlbumHeadlineWidget({
    super.key,
    required this.album,
    required this.token,
  });
  final String token;
  final Album album;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AlbumHeadlineWidgetState();
}

class _AlbumHeadlineWidgetState extends ConsumerState<AlbumHeadlineWidget> {
  bool liked = false;
  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() {
    final favoriteState = ref.watch(favoriteProvider);

    if (favoriteState is LoadedFavorite) {
      setState(() {
        liked = favoriteState.favorites
            .any((favorite) => favorite.id == widget.album.id);
      });
    }
  }

  void _handleFavoriteTap() {
    setState(() {
      final favoriteNotifier = ref.read(favoriteProvider.notifier);

      if (liked) {
        favoriteNotifier.deleteFavorite(widget.album.id, widget.token);
      } else {
        favoriteNotifier.addFavorite(widget.album.id, widget.token);
      }
      liked = !liked;
    });

    if (!liked) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Album removed from favorites'),
        duration: Duration(seconds: 1),
        backgroundColor: AppColors.listener3,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Album added to favorites'),
        duration: Duration(seconds: 1),
        backgroundColor: AppColors.listener3,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    IconData icon = liked ? Icons.favorite : Icons.favorite_border_outlined;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: deviceWidth * 0.7,
              child: Text(
                widget.album.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(
              "${widget.album.songs.length} tracks",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        GestureDetector(
          onTap: _handleFavoriteTap,
          child: Icon(
            icon,
            color: AppColors.listener2,
            size: 35,
          ),
        ),
      ],
    );
  }
}

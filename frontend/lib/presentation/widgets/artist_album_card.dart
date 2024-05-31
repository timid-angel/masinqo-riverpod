import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:masinqo/application/artists/artists_provider.dart';
import 'package:masinqo/application/artists/artists_state.dart';
import 'package:masinqo/application/auth/login/auth_providers.dart';
import 'package:masinqo/infrastructure/core/url.dart';

class AlbumCard extends ConsumerWidget {
  const AlbumCard({
    super.key,
    required this.album,
  });

  final AlbumState album;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final token = ref.read(artistLoginProvider).token;
    final localProvider = albumProvider(
        AlbumProviderParamters(token: token, albumId: album.albumId));
    final state = ref.watch(localProvider);
    if (state.albumId.isEmpty) {
      ref.read(localProvider.notifier).initializeAlbum(album);
    }

    return GestureDetector(
      onTap: () {
        context.pushNamed("artist_album", extra: state.albumId);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: Color(0xFF39DCF3),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: deviceWidth * 0.5,
                  height: deviceWidth * 0.5,
                  decoration: BoxDecoration(
                    image: state.albumArt.isNotEmpty
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                NetworkImage("${Domain.url}/${state.albumArt}"))
                        : null,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildText('', _truncateText(state.title, 25),
                            fontSize: 20, fontWeight: FontWeight.bold),
                        const SizedBox(height: 5),
                        _buildText('Tracks:', state.songs.length.toString()),
                        const SizedBox(height: 5),
                        _buildText('Genre:', _truncateText(state.genre, 14)),
                        const SizedBox(height: 5),
                        _buildText('Release Date:',
                            "${DateFormat('MMMM').format(DateTime(0, state.date.month)).toString().substring(0, 3)}. ${state.date.day.toString()}, ${state.date.year.toString()}"),
                        const SizedBox(height: 5),
                        _buildDescriptionText('Description:',
                            _truncateText(state.description, 55)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}

Widget _buildText(String label, String value,
    {Color? color, double? fontSize, FontWeight? fontWeight}) {
  return Row(
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF39DCF3),
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        child: SizedBox(
          width: double.infinity,
          child: Text(
            value,
            style: TextStyle(
              fontSize: fontSize ?? 14,
              color: color ?? Colors.white,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildDescriptionText(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF39DCF3),
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        value,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
    ],
  );
}

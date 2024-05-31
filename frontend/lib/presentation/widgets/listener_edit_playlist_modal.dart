import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_provider.dart';

class EditPlaylistModal extends ConsumerWidget {
  final String currentPlaylistName;
  final String token;
  final String id;

  const EditPlaylistModal({
    required this.id,
    super.key,
    required this.token,
    required this.currentPlaylistName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistNotifier = ref.read(playlistProvider.notifier);

    late String _newPlaylistName;

    _newPlaylistName = currentPlaylistName;

    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text('Edit Playlist', style: TextStyle(color: Colors.white)),
      content: TextFormField(
        initialValue: currentPlaylistName,
        onChanged: (value) {
          _newPlaylistName = value;
        },
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Enter new playlist name',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () {
            playlistNotifier.editPlaylists(id, _newPlaylistName, token);
            playlistNotifier.fetchPlaylists(token);
            Navigator.pop(context, _newPlaylistName);
          },
          child: const Text('Save Changes'),
        ),
      ],
    );
  }
}

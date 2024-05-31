import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/listener/listener_playlist/playlist_provider.dart';
import 'package:masinqo/presentation/widgets/delete_confirmation_modal.dart';

class DeletePlaylistModal extends ConsumerWidget {
  final String token;
  final String id;

  const DeletePlaylistModal({
    required this.id,
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DeleteConfirmationDialog(
      title: 'Are you sure you want to delete this playlist?',
      onConfirm: () {
        ref.read(playlistProvider.notifier).deletePlaylists(id, token);
        Navigator.of(context).pop();
      },
    );
  }
}

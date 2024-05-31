import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/admin/admin_providers.dart';
import 'package:masinqo/application/auth/login/auth_providers.dart';
import 'package:masinqo/domain/admin/admin_artists/admin_artists.dart';
import 'package:masinqo/infrastructure/core/url.dart';
import 'package:masinqo/presentation/widgets/admin_empty_list.dart';
import 'package:masinqo/presentation/widgets/admin_header.dart';
import 'package:masinqo/presentation/widgets/delete_confirmation_modal.dart';

class AdminArtistMGT extends ConsumerWidget {
  const AdminArtistMGT({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tk = ref.read(adminLoginProvider).token;
    final state = ref.watch(artistProvider(tk));
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AdminHeader(),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              'Artists',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
          state.artists.isEmpty
              ? const Expanded(child: AdminEmptyList())
              : Expanded(
                  child: ArtistList(
                    artistData: state.artists,
                  ),
                ),
        ],
      ),
    );
  }
}

class ArtistList extends ConsumerWidget {
  final List<AdminArtist> artistData;
  const ArtistList({super.key, required this.artistData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tk = ref.read(adminLoginProvider).token;
    final provider = artistProvider(tk);
    return ListView.builder(
      itemCount: artistData.length,
      itemBuilder: (context, index) {
        final artist = artistData[index];
        final isBanned = artist.isBanned;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(
                          artist.profilePicture.isNotEmpty
                              ? "${Domain.url}/${artist.profilePicture}"
                              : "${Domain.url}/local/artist_placeholder.jpg"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          artist.name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          artist.email,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Spacer(),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                isBanned ? Icons.circle_outlined : Icons.block,
                                color: isBanned
                                    ? const Color.fromARGB(211, 41, 251, 48)
                                    : Colors.yellow,
                              ),
                              label: Text(
                                isBanned ? 'Unban' : 'Ban',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              onPressed: () {
                                String title = isBanned
                                    ? 'Are you sure you want to ban this artist?'
                                    : 'Are you sure you want to unban this artist?';
                                String content = isBanned
                                    ? 'This action will restrict the artist from accessing the platform.'
                                    : 'This action will allow the artist to access the platform.';

                                void activateStatusChange() {
                                  ref
                                      .read(provider.notifier)
                                      .changeArtistStatus(artist.id, isBanned);
                                }

                                showDeleteConfirmationDialog(
                                  context,
                                  title,
                                  content,
                                  activateStatusChange,
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text(
                                'Delete',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              onPressed: () {
                                void activateDeletion() {
                                  ref
                                      .read(provider.notifier)
                                      .deleteArtist(artist.id);
                                }

                                showDeleteConfirmationDialog(
                                  context,
                                  'Are you sure you want to delete this artist?',
                                  'This action will remove all of their information including their albums and songs.',
                                  activateDeletion,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.grey),
            ],
          ),
        );
      },
    );
  }
}

void showDeleteConfirmationDialog(BuildContext context, String title,
    String content, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteConfirmationDialog(
        title: title,
        onConfirm: onConfirm,
      );
    },
  );
}

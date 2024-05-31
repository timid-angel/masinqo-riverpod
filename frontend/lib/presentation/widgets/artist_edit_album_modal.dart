import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/artists/artists_provider.dart';
import 'package:masinqo/application/auth/login/auth_providers.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';

class EditSongModal extends ConsumerWidget {
  late final TextEditingController titleController =
      TextEditingController(text: "");
  late final TextEditingController genreController =
      TextEditingController(text: "");
  late final TextEditingController descriptionController =
      TextEditingController(text: "");
  final String albumId;

  EditSongModal({
    super.key,
    required this.albumId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.read(artistLoginProvider).token;
    final localProvider =
        albumProvider(AlbumProviderParamters(token: token, albumId: albumId));
    final state = ref.watch(localProvider);

    if (titleController.text.isEmpty) {
      titleController.text = state.title;
      genreController.text = state.genre;
      descriptionController.text = state.description;
    }

    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Edit Album',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Album Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: AppColors.artist2),
                ),
              ),
              const SizedBox(height: 2.0),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter new album name',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF39DCF3)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Genre",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: AppColors.artist2),
                ),
              ),
              const SizedBox(height: 2.0),
              TextFormField(
                controller: genreController,
                decoration: const InputDecoration(
                  hintText: 'Enter new genre',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF39DCF3)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: AppColors.artist2),
                ),
              ),
              const SizedBox(height: 2.0),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter new description',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF39DCF3)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  ref.read(localProvider.notifier).updateAlbum(
                      titleController.text,
                      genreController.text,
                      descriptionController.text);
                  ref.read(homePageProvider(token).notifier).updateHomeAlbum(
                      state.albumId,
                      titleController.text,
                      genreController.text,
                      descriptionController.text);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Edited Album Successfully"),
                      backgroundColor: Color.fromARGB(255, 34, 126, 25),
                    ),
                  );
                  context.pop();
                },
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Color(0xFF39DCF3)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

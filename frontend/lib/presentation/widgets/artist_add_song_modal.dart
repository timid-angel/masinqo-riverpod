import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/artists/artists_provider.dart';
import 'package:masinqo/application/auth/login/auth_providers.dart';

class AddSongModal extends ConsumerStatefulWidget {
  final String albumId;
  const AddSongModal({super.key, required this.albumId});

  @override
  AddSongModalState createState() => AddSongModalState();
}

class AddSongModalState extends ConsumerState<AddSongModal> {
  late final TextEditingController _songNameController =
      TextEditingController();
  late String _filePath = '';

  void _pickSong() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    if (result != null) {
      setState(() {
        _filePath = result.files.single.path ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = ref.read(artistLoginProvider).token;
    final localProvider = albumProvider(
        AlbumProviderParamters(token: token, albumId: widget.albumId));

    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Add Song',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _songNameController,
              decoration: const InputDecoration(
                hintText: 'Enter song name',
                hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF39DCF3)),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _pickSong,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),
              child: const Text('Pick Song File'),
            ),
            if (_filePath.isNotEmpty)
              Text(
                'Selected file: $_filePath',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                final String songName = _songNameController.text.trim();
                if (songName.isNotEmpty && _filePath.isNotEmpty) {
                  ref.read(localProvider.notifier).addSong(songName, _filePath);
                  context.pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Please enter a song name and pick a file.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Add Song',
                  style: TextStyle(color: Color(0xFF39DCF3))),
            ),
          ],
        ),
      ),
    );
  }
}

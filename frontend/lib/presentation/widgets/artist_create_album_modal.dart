import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:masinqo/application/artists/artists_provider.dart';
import 'package:masinqo/application/artists/artists_state.dart';
import 'package:masinqo/application/auth/login/auth_providers.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';

class CreateAlbumModal extends ConsumerStatefulWidget {
  final String token;

  const CreateAlbumModal({super.key, required this.token});
  @override
  CreateAlbumModalContentState createState() => CreateAlbumModalContentState();
}

class CreateAlbumModalContentState extends ConsumerState<CreateAlbumModal> {
  late TextEditingController _nameController;
  late TextEditingController _genreController;
  late TextEditingController _descriptionController;
  String? _thumbnailPath;
  String? _type;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _genreController = TextEditingController();
    _descriptionController = TextEditingController();
    _type = 'Album';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genreController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _thumbnailPath = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = ref.read(artistLoginProvider).token;
    final homePageProv = homePageProvider(token);
    final createAlbumProv = createAlbumProvider(token);

    ref.listen(createAlbumProv, (prev, next) {
      if (next is AlbumSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((next as AlbumSuccess).message),
            backgroundColor: const Color.fromARGB(255, 34, 126, 25),
          ),
        );
        ref.read(homePageProv.notifier).getArtistInformation();
        context.pop();
      } else if (next is AlbumFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((next as AlbumFailure).errorMessage),
            backgroundColor: const Color.fromARGB(255, 150, 53, 53),
          ),
        );
      }
    });
    return AlertDialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Create Album',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle,
                      color: Color(0xFF39DCF3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Album name',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF39DCF3)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _genreController,
                decoration: const InputDecoration(
                  hintText: 'Genre',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF39DCF3)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF39DCF3)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Type: ',
                    style: TextStyle(color: Colors.white),
                  ),
                  DropdownButton<String>(
                    value: _type,
                    onChanged: (String? newValue) {
                      setState(() {
                        _type = newValue!;
                      });
                    },
                    items: <String>['Album', 'Single']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _pickImage,
                child: Text(
                  _thumbnailPath != null
                      ? 'Change Thumbnail'
                      : 'Pick Thumbnail',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              if (_thumbnailPath != null)
                Image.file(
                  File(_thumbnailPath!),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(createAlbumProv.notifier).addAlbum(
                        CreateAlbumDTO(
                            type: _type!,
                            title: _nameController.text,
                            genre: _genreController.text,
                            description: _descriptionController.text,
                            albumArt: _thumbnailPath ?? ""),
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF39DCF3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

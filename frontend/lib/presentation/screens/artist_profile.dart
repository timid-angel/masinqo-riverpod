import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/artists/artists_provider.dart';
import 'package:masinqo/application/artists/artists_state.dart';
import 'package:masinqo/application/auth/login/auth_providers.dart';
import 'package:masinqo/infrastructure/core/url.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/profile_mgmt_section_title.dart';
import 'dart:io';
import '../widgets/artist_app_bar.dart';

class ArtistProfile extends ConsumerStatefulWidget {
  final Map<String, String> initialData;
  const ArtistProfile({super.key, required this.initialData});

  @override
  ArtistProfileState createState() => ArtistProfileState();
}

class ArtistProfileState extends ConsumerState<ArtistProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _profileImagePath = 'assets/images/transparent.png';
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialData["name"]);
    emailController = TextEditingController(text: widget.initialData["email"]);
  }

  @override
  Widget build(BuildContext context) {
    final provider = homePageProvider(ref.read(artistLoginProvider).token);
    final homePageState = ref.read(provider);
    ref.listen(provider, (prev, next) {
      if (next is ArtistHomeFailureState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: const Color.fromARGB(255, 150, 53, 53),
          ),
        );
        ref.read(provider.notifier).completedEvent(next);
      } else if (next is ArtistHomeSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Successfully Updated Personal Information"),
            backgroundColor: AppColors.artist2,
          ),
        );
        ref.read(provider.notifier).completedEvent(next);
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: ArtistAppBar(scaffoldKey: _scaffoldKey),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF39DCF3), width: 4),
                        image: DecorationImage(
                            image: homePageState.profilePicture.isNotEmpty
                                ? NetworkImage(
                                    "${Domain.url}/${homePageState.profilePicture}")
                                : const NetworkImage(
                                    "${Domain.url}/local/artist_placeholder.jpg"))),
                    child: ClipOval(
                      child: profilePicture(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Color(0xFF39DCF3)),
                      onPressed: _pickProfileImage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                homePageState.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFC5F8FF),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Change Username'),
              RoundedInputField(
                placeholder: "Enter new username",
                controller: nameController,
              ),
              RoundedInputField(
                placeholder: "Enter new Email",
                controller: emailController,
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Change Password'),
              const SizedBox(height: 10),
              RoundedInputField(
                placeholder: "Enter new password",
                controller: passwordController,
              ),
              RoundedInputField(
                placeholder: "Confirm new Password",
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  ref.read(provider.notifier).updateArtistInformation(
                      _profileImagePath != 'assets/images/transparent.png'
                          ? _profileImagePath
                          : "",
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      confirmPasswordController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF39DCF3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 75),
            ],
          ),
        ),
      ),
    );
  }

  void _pickProfileImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        _profileImagePath = result.files.single.path!;
      });
    }
  }

  Widget profilePicture() {
    if (_profileImagePath.isEmpty) {
      return Image.asset(
        "assets/images/black.png",
        fit: BoxFit.cover,
      );
    }

    if (_profileImagePath.startsWith('assets/')) {
      return Image.asset(
        _profileImagePath,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(_profileImagePath),
        fit: BoxFit.cover,
      );
    }
  }
}

class RoundedInputField extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;

  const RoundedInputField(
      {super.key, required this.placeholder, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFF39DCF3), width: 1),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.grey),
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

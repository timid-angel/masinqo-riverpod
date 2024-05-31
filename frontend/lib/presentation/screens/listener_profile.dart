import 'package:flutter/material.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/profile_mgmt_section_title.dart';

class ListenerProfile extends StatefulWidget {
  final String token;

  const ListenerProfile({super.key, required this.token});

  @override
  ListenerProfileState createState() => ListenerProfileState();
}

class ListenerProfileState extends State<ListenerProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              profilePicture(),
              const SizedBox(height: 5),
              const Text(
                'Username',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 238, 197, 255),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Change Username'),
              RoundedInputField(
                placeholder: "Enter new username",
                controller: _usernameController,
              ),
              const SizedBox(height: 2),
              RoundedInputField(
                placeholder: "Enter new Email",
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Change Password'),
              const SizedBox(height: 10),
              RoundedInputField(
                placeholder: "Enter new password",
                controller: _passwordController,
              ),
              const SizedBox(height: 2),
              RoundedInputField(
                  placeholder: "Confirm new Password",
                  controller: _confirmPasswordController),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // context.read<ProfileBloc>().add(
                  //       EditProfile(
                  //           token: widget.token,
                  //           name: _usernameController.text,
                  //           email: _emailController.text,
                  //           password: _passwordController.text),
                  //     );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.listener2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 75)
            ],
          ),
        ),
      ),
    );
  }

  Widget profilePicture() {
    return Stack(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/user.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
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
        border: Border.all(color: AppColors.listener2, width: 1),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

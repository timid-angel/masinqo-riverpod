import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/listener/listener_profile/profile_provider.dart';
import 'package:masinqo/application/listener/listener_profile/profile_state.dart';

class ListenerDrawer extends ConsumerWidget {
  final String token;

  const ListenerDrawer({super.key, required this.token});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(profileProvider.notifier).fetchProfile(token);
    final ProfileState profileState = ref.watch(profileProvider);
    // context.read<ProfileBloc>().add(FetchProfile(token: token));

    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: const Color.fromARGB(235, 0, 0, 0),
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Container(
                    width: 98,
                    height: 98,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                  ),
                  const SizedBox(height: 5),
                  profileState is LoadedProfile
                      ? Text(
                          profileState.profile.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 238, 197, 255),
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      : const Text(
                          "Username",
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Profile Management",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              onTap: () {
                final args = ProfileArgument(token: token);
                context.pushNamed("listener_profile", extra: args);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              onTap: () {
                context.go("/login");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileArgument {
  final String token;

  ProfileArgument({required this.token});
}

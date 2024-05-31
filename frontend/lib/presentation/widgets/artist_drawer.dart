import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:masinqo/application/artists/artists_provider.dart';
import 'package:masinqo/application/auth/login/auth_providers.dart';
import 'package:masinqo/infrastructure/core/url.dart';

class ArtistDrawer extends ConsumerWidget {
  const ArtistDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tk = ref.read(artistLoginProvider).token;
    final state = ref.watch(homePageProvider(tk));
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF39DCF3),
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: state.profilePicture.isNotEmpty
                          ? NetworkImage(
                              "${Domain.url}/${state.profilePicture}")
                          : const NetworkImage(
                              "${Domain.url}/local/artist_placeholder.jpg"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const Divider(color: Color.fromARGB(255, 156, 153, 153)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                'Profile Management',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                context.pushNamed("artist_profile", extra: <String, String>{
                  "name": state.name,
                  "email": state.email
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text(
                'Logout',
                style: TextStyle(color: Color.fromARGB(255, 241, 211, 211)),
              ),
              onTap: () {
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}

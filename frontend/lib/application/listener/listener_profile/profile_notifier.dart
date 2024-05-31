import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/listener/listener_profile/profile_state.dart';
import 'package:masinqo/domain/listener/listener_profile.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ListenerProfileCollection profileRepository;

  ProfileNotifier({required this.profileRepository}) : super(EmptyProfile());
  Future<void> fetchProfile(String token) async {
    try {
      final profile = await profileRepository.getProfile(token);
      state = LoadedProfile(profile);
    } catch (e) {
      state = ErrorProfile(e.toString());
    }
  }

  Future<void> editProfile(
      String token, String name, String email, String password) async {
    try {
      final profile =
          await profileRepository.editProfile(token, name, email, password);
      state = LoadedProfile(profile);
    } catch (e) {
      state = ErrorProfile(e.toString());
    }
  }
}

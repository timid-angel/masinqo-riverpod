import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/application/listener/listener_profile/profile_notifier.dart';
import 'package:masinqo/application/listener/listener_profile/profile_state.dart';
import 'package:masinqo/domain/listener/listener_profile.dart';

final profileRepositoryProvider = Provider<ListenerProfileCollection>((ref) {
  return ListenerProfileCollection();
});

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final profileRepository = ref.read(profileRepositoryProvider);
  return ProfileNotifier(profileRepository: profileRepository);
});

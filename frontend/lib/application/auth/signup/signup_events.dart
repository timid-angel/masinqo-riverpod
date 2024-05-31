import 'package:masinqo/domain/entities/artists.dart';
import 'package:masinqo/domain/entities/listener.dart';

abstract class ASignupEvent {}

class ArtistSignupEvent extends ASignupEvent {
  final Artist artist;
  final String confirmPassword;

  ArtistSignupEvent({
    required this.artist,
    required this.confirmPassword,
  });
}

class AResetState extends ASignupEvent {}

abstract class LSignupEvent {}

class ListenerSignupEvent extends LSignupEvent {
  final Listener listener;
  final String confirmPassword;

  ListenerSignupEvent({
    required this.listener,
    required this.confirmPassword,
  });
}

class LResetState extends LSignupEvent {}

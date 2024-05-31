import 'package:equatable/equatable.dart';

abstract class ArtistSignupState extends Equatable {
  const ArtistSignupState();

  @override
  List<Object> get props => [];
}

class SignupInitialA extends ArtistSignupState {}

class SignupLoadingA extends ArtistSignupState {}

class ArtistSignupSuccess extends ArtistSignupState {}

class ArtistSignupFailure extends ArtistSignupState {
  final String error;

  const ArtistSignupFailure({required this.error});
}

abstract class ListenerSignupState extends Equatable {
  const ListenerSignupState();

  @override
  List<Object> get props => [];
}

class SignupInitialL extends ListenerSignupState {}

class SignupLoadingL extends ListenerSignupState {}

class ListenerSignupSuccess extends ListenerSignupState {}

class ListenerSignupFailure extends ListenerSignupState {
  final String error;

  const ListenerSignupFailure({required this.error});

  @override
  List<Object> get props => [error];
}

import 'package:equatable/equatable.dart';

class ArtistHomeState {
  final String name;
  final String email;
  final String profilePicture;
  List albums;
  ArtistHomeState(
      {required this.name,
      required this.email,
      required this.profilePicture,
      required this.albums});
}

class ArtistHomeFailureState extends ArtistHomeState {
  final String errorMessage;
  ArtistHomeFailureState({
    required super.name,
    required super.email,
    required super.profilePicture,
    required super.albums,
    required this.errorMessage,
  });
}

class ArtistHomeSuccessState extends ArtistHomeState {
  ArtistHomeSuccessState(
      {required super.name,
      required super.email,
      required super.profilePicture,
      required super.albums});
}

abstract class ArtistAlbumState extends Equatable {
  const ArtistAlbumState();

  @override
  List<Object?> get props => [];
}

class AlbumInitial extends ArtistAlbumState {}

class AlbumLoading extends ArtistAlbumState {}

class AlbumSuccess extends ArtistAlbumState {
  final String message;

  const AlbumSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AlbumFailure extends ArtistAlbumState {
  final String errorMessage;

  const AlbumFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class Song {
  final String name;
  final String filePath;

  Song({
    required this.name,
    required this.filePath,
  });
}

class AlbumState {
  final String title;
  final String albumArt;
  List<Song> songs;
  final String artist;
  final String description;
  final String genre;
  final DateTime date;
  bool isDeleted;
  String error;
  final String albumId;

  AlbumState({
    required this.title,
    required this.albumArt,
    required this.songs,
    required this.description,
    required this.genre,
    required this.date,
    required this.artist,
    required this.error,
    this.isDeleted = false,
    required this.albumId,
  });
}

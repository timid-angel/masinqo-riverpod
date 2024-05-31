import 'package:equatable/equatable.dart';
import 'package:masinqo/application/artists/artists_state.dart';
import 'package:masinqo/domain/entities/albums.dart';
import 'package:flutter/material.dart';

abstract class ArtistHomeEvent extends Equatable {
  const ArtistHomeEvent();

  @override
  List<Object?> get props => [];
}

class UpdateArtistInformation extends ArtistHomeEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String profilePictureFilePath;

  const UpdateArtistInformation({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.profilePictureFilePath,
  });

  @override
  List<Object?> get props => [name, email, password, profilePictureFilePath];
}

class GetArtistInformation extends ArtistHomeEvent {}

class RemoveDeletedAlbum extends ArtistHomeEvent {
  final String albumId;

  const RemoveDeletedAlbum({required this.albumId});
}

class CreateNewAlbum extends ArtistHomeEvent {
  final Album album;

  const CreateNewAlbum({required this.album});
}

class HomeAlbumUpdateEvent extends ArtistHomeEvent {
  final String albumId;
  final String title;
  final String genre;
  final String description;

  const HomeAlbumUpdateEvent({
    required this.title,
    required this.genre,
    required this.description,
    required this.albumId,
  });
}

class CompletedEvent extends ArtistHomeEvent {
  final ArtistHomeState errorState;

  const CompletedEvent({required this.errorState});
}

abstract class ArtistAlbumEvent extends Equatable {
  const ArtistAlbumEvent();

  @override
  List<Object?> get props => [];
}

class AddAlbumEvent extends ArtistAlbumEvent {
  final String title;
  final String genre;
  final String description;
  final String type;
  final String? albumArt;

  const AddAlbumEvent({
    required this.title,
    required this.genre,
    required this.description,
    required this.type,
    this.albumArt,
  });

  @override
  List<Object?> get props => [title, genre, description, type, albumArt];
}

abstract class AlbumEvent {}

class AddSongEvent extends AlbumEvent {
  final String songName;
  final String songFilePath;

  AddSongEvent({
    required this.songName,
    required this.songFilePath,
  });
}

class DeleteAlbumEvent extends AlbumEvent {
  final String albumId;
  final BuildContext context;

  DeleteAlbumEvent({required this.albumId, required this.context});
}

class DeleteSongEvent extends AlbumEvent {
  final String songName;
  final String albumId;

  DeleteSongEvent({required this.songName, required this.albumId});
}

class AlbumUpdateEvent extends AlbumEvent {
  final String title;
  final String genre;
  final String description;

  AlbumUpdateEvent(
      {required this.title, required this.genre, required this.description});
}

import 'package:masinqo/domain/entities/songs.dart';

class Album {
  final String id;
  final String title;
  final String albumArt;
  final List<Song> songs;
  final String artist;
  final String description;
  final String genre;
  final DateTime date;

  Album({
    required this.id,
    required this.title,
    required this.albumArt,
    required this.songs,
    required this.description,
    required this.genre,
    required this.date,
    required this.artist,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    final r = Album(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      albumArt: json['albumArtPath'] ?? '',
      description: json['description'] ?? '',
      genre: json['genre'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now()),
      artist: json['artist'] ?? "",
      songs: (json['songs'] as List<dynamic>)
          .map((songJson) => Song.fromJson(songJson))
          .toList(),
    );
    // print("Ad");
    // print(r);
    return r;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'albumArtPath': albumArt,
      'description': description,
      'genre': genre,
      'date': date.toIso8601String(),
      'artist': artist,
      'songs': songs.map((song) => song.toJson()).toList(),
      '_id': id,
    };
  }
}

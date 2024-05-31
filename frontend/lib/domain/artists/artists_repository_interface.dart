import 'package:dartz/dartz.dart';
import 'package:masinqo/core.dart';
import 'package:masinqo/domain/artists/artists_success.dart';
import 'package:masinqo/infrastructure/artists/artists_dto.dart';
import 'package:masinqo/infrastructure/artists/artists_failure.dart';
import 'package:masinqo/infrastructure/artists/artists_success.dart';

abstract class ArtistsRepositoryInterface {
  get token => String;

  Future<Either<ArtistFailure, GetAlbumsSuccess>> getAlbums();
  Future<Either<ArtistFailure, AddAlbumSuccess>> addAlbum(
      CreateAlbumDTO albumDto);
  Future<Either<ArtistFailure, Success>> deleteAlbum(String albumId);
  Future<Either<ArtistFailure, Success>> updateAlbum(UpdateAlbumDTO updateDto);
  Future<Either<ArtistFailure, GetSongsSuccess>> getSongs(String albumId);
  Future<Either<ArtistFailure, Success>> addSong(
      CreateSongDTO songDto, String songFilePath);
  Future<Either<ArtistFailure, Success>> removeSong(
      String albumId, String songName);
  Future<Either<ArtistFailure, Success>> updateInformation(
      UpdateArtistInformatioDTO artist);
  Future<Either<ArtistFailure, GetArtistInformationSuccess>>
      getArtistInformation();
}

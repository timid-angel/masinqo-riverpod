import 'package:dartz/dartz.dart';
import 'package:masinqo/domain/admin/admin_artists/admin_artists_repository_interface.dart';
import 'package:masinqo/domain/admin/admin_failure.dart';
import 'package:masinqo/domain/admin/admin_success.dart';
import 'package:masinqo/infrastructure/admin/admin_artists/admin_artists_dto.dart';

class AdminArtistsCollection {
  late List<AdminArtist> listeners;
  final AdminArtistRepositoryInterface adminArtistsRepository;

  AdminArtistsCollection({
    required this.adminArtistsRepository,
  });
  Future<Either<AdminFailure, GetArtistsSuccess>> getArtists() async {
    if (adminArtistsRepository.token?.isEmpty ?? true) {
      return Left(AdminFailure(message: "Invalid token"));
    }

    final res = await adminArtistsRepository.getArtists();
    final Either<AdminFailure, GetArtistsSuccess> result = res.fold((l) {
      return Left(AdminFailure(message: l.message));
    }, (r) {
      return Right(GetArtistsSuccess(
          listeners: r.artists
              .map(
                (a) => AdminArtist(
                  id: a.id,
                  email: a.email,
                  name: a.name,
                  isBanned: a.isBanned,
                  profilePicture: a.profilePicture,
                ),
              )
              .toList()));
    });

    return result;
  }

  Future<Either<AdminFailure, AdminSuccess>> deleteArtist(String id) async {
    if (adminArtistsRepository.token?.isEmpty ?? true) {
      return Left(AdminFailure(message: "Invalid token"));
    }
    final res = await adminArtistsRepository.deleteArtist(ArtistID(id: id));

    final Either<AdminFailure, AdminSuccess> result = res.fold((l) {
      return Left(AdminFailure(message: l.message));
    }, (r) {
      return Right(AdminSuccess());
    });

    return result;
  }

  Future<Either<AdminFailure, AdminSuccess>> changeStatus(
      String id, bool newBannedStatus) async {
    if (adminArtistsRepository.token?.isEmpty ?? true) {
      return Left(AdminFailure(message: "Invalid token"));
    }
    final res = await adminArtistsRepository
        .changeStatus(ArtistStatus(id: id, newBannedStatus: newBannedStatus));

    final Either<AdminFailure, AdminSuccess> result = res.fold((l) {
      return Left(AdminFailure(message: l.message));
    }, (r) {
      return Right(AdminSuccess());
    });

    return result;
  }
}

class AdminArtist {
  final String email;
  final String id;
  final String name;
  bool isBanned;
  final String profilePicture;

  AdminArtist({
    required this.id,
    required this.email,
    required this.name,
    required this.isBanned,
    required this.profilePicture,
  });
}

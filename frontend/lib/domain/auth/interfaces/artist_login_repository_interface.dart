import 'package:dartz/dartz.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart';
import 'package:masinqo/infrastructure/auth/login_failure.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';

abstract class ArtistLoginRepositoryInterface {
  Future<Either<LoginRequestFailure, LoginRequestSuccess>> artistLogin(
      ArtistLoginDTO loginDto);
}

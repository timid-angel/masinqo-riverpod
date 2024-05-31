import 'package:dartz/dartz.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_dto.dart';
import 'package:masinqo/infrastructure/auth/login_failure.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';

abstract class ListenerLoginRepositoryInterface {
  Future<Either<LoginRequestFailure, LoginRequestSuccess>> listenerLogin(
      ListenerLoginDTO loginDto);
}

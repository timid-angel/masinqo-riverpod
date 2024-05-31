import 'package:dartz/dartz.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_dto.dart';
import 'package:masinqo/infrastructure/auth/login_failure.dart';
import 'package:masinqo/infrastructure/auth/login_success.dart';

abstract class AdminLoginRepositoryInterface {
  Future<Either<LoginRequestFailure, LoginRequestSuccess>> adminLogin(
      LoginDTO loginDto);
}

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:email_validator/email_validator.dart';
import 'package:masinqo/domain/auth/interfaces/admin_login_repository_interface.dart';
import 'package:masinqo/domain/auth/interfaces/artist_login_repository_interface.dart';
import 'package:masinqo/domain/auth/interfaces/listener_login_repository_interface.dart';
import 'package:masinqo/domain/auth/login/login_failure.dart';
import 'package:masinqo/domain/auth/login/login_success.dart';
import 'package:masinqo/infrastructure/auth/admin/admin_login_dto.dart';
import 'package:masinqo/infrastructure/auth/artist/artist_login_dto.dart';
import 'package:masinqo/infrastructure/auth/listener/listener_login_dto.dart';

class AdminAuthEntity {
  final String email;
  final String password;
  late String token;
  final AdminLoginRepositoryInterface adminLoginRepo;

  AdminAuthEntity(
      {required this.email,
      required this.password,
      required this.adminLoginRepo});

  Future<Either<LoginFailure, LoginSuccess>> loginAdmin() async {
    LoginFailure loginFailure = LoginFailure();
    if (password.length < 6) {
      loginFailure.messages.add("The password is too short");
    }

    if (!EmailValidator.validate(email)) {
      loginFailure.messages.add("Invalid Email");
    }

    if (loginFailure.messages.isNotEmpty) {
      return Left(loginFailure);
    }

    final res = await adminLoginRepo
        .adminLogin(LoginDTO(email: email, password: password));

    return res.fold((l) {
      if (l.message.startsWith('{"')) {
        loginFailure.messages.add(jsonDecode(l.message)["message"]);
        return Left(loginFailure);
      }
      loginFailure.messages.add(l.message == "Conflict"
          ? "Incorrect email or password"
          : "Connection Error");
      return Left(loginFailure);
    }, (r) {
      token = r.token;
      return Right(LoginSuccess(token: r.token));
    });
  }
}

class ListenerAuthEntity {
  final String email;
  final String password;
  final ListenerLoginRepositoryInterface listenerLoginRepo;

  ListenerAuthEntity(
      {required this.email,
      required this.password,
      required this.listenerLoginRepo});

  Future<Either<LoginFailure, LoginSuccess>> loginListener() async {
    LoginFailure loginFailure = LoginFailure();

    if (!EmailValidator.validate(email)) {
      loginFailure.messages.add("Invalid Email");
    }

    if (password.length < 6) {
      loginFailure.messages.add("The password is too short");
    }

    if (loginFailure.messages.isNotEmpty) {
      return Left(loginFailure);
    }

    final res = await listenerLoginRepo
        .listenerLogin(ListenerLoginDTO(email: email, password: password));

    return res.fold((l) {
      if (l.message.startsWith('{"')) {
        loginFailure.messages.add(jsonDecode(l.message)["message"]);
        return Left(loginFailure);
      }
      loginFailure.messages.add(l.message == "Conflict"
          ? "Incorrect email or password"
          : "Connection Error");
      return Left(loginFailure);
    }, (r) {
      return Right(LoginSuccess(token: r.token));
    });
  }
}

class ArtistAuthEntity {
  final String email;
  final String password;
  final ArtistLoginRepositoryInterface artistLoginRepo;

  ArtistAuthEntity(
      {required this.email,
      required this.password,
      required this.artistLoginRepo});

  Future<Either<LoginFailure, LoginSuccess>> loginArtist() async {
    LoginFailure loginFailure = LoginFailure();
    if (!EmailValidator.validate(email)) {
      loginFailure.messages.add("Invalid Email");
    }

    if (password.length < 6) {
      loginFailure.messages.add("The password is too short");
    }

    if (loginFailure.messages.isNotEmpty) {
      return Left(loginFailure);
    }

    final res = await artistLoginRepo
        .artistLogin(ArtistLoginDTO(email: email, password: password));

    return res.fold((l) {
      if (l.message.startsWith('{"')) {
        loginFailure.messages.add(jsonDecode(l.message)["message"]);
        return Left(loginFailure);
      }
      loginFailure.messages.add(
          l.message == "Conflict" ? "Incorrect email or password" : l.message);
      return Left(loginFailure);
    }, (r) {
      return Right(LoginSuccess(token: r.token));
    });
  }
}

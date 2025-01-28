import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/auth/data/data_source/remote_local_source/auth_remote_datasource.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/entity/auth_entity.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRemoteRepository(this._authRemoteDatasource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginStudent(
      String username, String password) async {
    try {
      final token =
          await _authRemoteDatasource.loginStudent(username, password);

      return Right(token);
    } catch (e) {
      //
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerStudent(AuthEntity student) async {
    try {
      await _authRemoteDatasource.registerStudent(student);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDatasource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
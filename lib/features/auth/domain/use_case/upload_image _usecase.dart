import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/app/usecase/usecase.dart';

import '../../../../core/error/failure.dart';
import '../repository/auth_repository.dart';

class UploadImageParams {
  final File file;
  
  const UploadImageParams({
    required this.file,
   
  });
}

class UploadImageUsecase
    implements UsecaseWithParams<String, UploadImageParams> {
  final IAuthRepository _repository;

  UploadImageUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params)  {
    return  _repository.uploadProfilePicture(params.file);
  }
}
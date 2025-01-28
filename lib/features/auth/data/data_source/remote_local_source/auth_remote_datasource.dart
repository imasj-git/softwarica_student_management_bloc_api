import 'dart:io';

import 'package:dio/dio.dart';
import 'package:softwarica_student_management_bloc/app/constants/api_endpoints.dart';
import 'package:softwarica_student_management_bloc/features/auth/data/data_source/auth_data_source.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;
  AuthRemoteDatasource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginStudent(String username, String password) async {
    try {
      // Sending a POST
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "username": username,
          "password": password,
        },
      );

      //
      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception('An error required in $e');
    }
  }

  @override
  Future<void> registerStudent(AuthEntity student) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "fname": student.fName,
          "lname": student.lName,
          "phone": student.phone,
          "image": student.image,
          "username": student.username,
          "batch": student.batch.batchId,
          "course": student.courses.map((e) => e.courseId).toList(),
          "password": student.password,
        },
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
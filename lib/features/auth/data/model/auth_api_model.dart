import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/entity/auth_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/model/batch_api_model.dart';
import 'package:softwarica_student_management_bloc/features/course/data/model/course_api_model.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable{
  @JsonKey(name: '_id')
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final String phone;
  final BatchApiModel batch;
  final List<CourseApiModel> courses;
  final String username;
  final String? password;

  const AuthApiModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.image,
    required this.phone,
    required this.batch,
    required this.courses,
    required this.username,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic>json)=>
  _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson()=> _$AuthApiModelToJson(this);

  // To Entity
AuthEntity toEntity(){
  return AuthEntity(
    userId: id,
    fName: fname,
    lName: lname,
    image: image,
    phone: phone,
    batch:batch.toEntity(),
    courses: courses.map((e)=>e.toEntity()).toList(),
    username: username,
    password: password ?? '',
  );
}

// From Entity

factory AuthApiModel.fromEntity(AuthEntity entity){
  return AuthApiModel(
    fname: entity.fName, 
    lname: entity.lName, 
    image: entity.image, 
    phone: entity.phone, 
    batch: BatchApiModel.fromEntity(entity.batch), 
    courses: entity.courses.map((e)=> CourseApiModel.fromEntity(e)).toList(), 
    username: entity.username, 
    password: entity.password,
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}
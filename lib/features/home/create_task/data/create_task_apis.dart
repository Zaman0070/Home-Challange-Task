// ignore_for_file: override_on_non_overriding_member

import 'package:dio/dio.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/core/constants/app_constant.dart';
import 'package:home_challenger_for_flutter/models/task_model.dart';
import 'package:home_challenger_for_flutter/common/common_provider/dio_client.dart';
import 'package:home_challenger_for_flutter/common/common_provider/end_points.dart';

DioClient getDioClient() {
  return DioClient();
}

final createTaskDataSourceProvider = Provider<CreateTaskDataSource>((ref) {
  final dioClient = getDioClient();
  return ICreateTaskDataSource(dioClient: dioClient);
});

abstract class CreateTaskDataSource {
  FutureEither createTask({required TaskModel formData});
  FutureEither updateTask({required TaskModel formData});
  FutureEither markAsClose({required String id});
}

class ICreateTaskDataSource extends CreateTaskDataSource {
  DioClient dioClient;
  ICreateTaskDataSource({required this.dioClient});

  @override
  FutureEither createTask({required TaskModel formData}) async {
    try {
      final response = await dioClient.post(
        Endpoints.baseUrl + Endpoints.taskEndPoint,
        data: formData.toJson(),
        options: Options(
          headers: header(authToken: 'Bearer ${Endpoints.apiToken}'),
        ),
      );
      return Right(response);
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  // update task
  @override
  FutureEither updateTask({required TaskModel formData}) async {
    try {
      final response = await dioClient.post(
        '${Endpoints.baseUrl}${Endpoints.taskEndPoint}/${formData.id}',
        data: formData.toJson(),
        options: Options(
          headers: header(authToken: 'Bearer ${Endpoints.apiToken}'),
        ),
      );
      return Right(response);
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither markAsClose({required String id}) async {
    try {
      final response = await dioClient.post(
        '${Endpoints.baseUrl}${Endpoints.taskEndPoint}/$id/close',
        options: Options(
          headers: header(authToken: 'Bearer ${Endpoints.apiToken}'),
        ),
      );
      return Right(response);
    } catch (e, st) {
      return Left(Failure(e.toString(), st));
    }
  }
}

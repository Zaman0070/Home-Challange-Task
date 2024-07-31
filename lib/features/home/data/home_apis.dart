// ignore_for_file: override_on_non_overriding_member

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/core/constants/app_constant.dart';
import 'package:home_challenger_for_flutter/models/comment_model.dart';
import 'package:home_challenger_for_flutter/models/task_model.dart';
import 'package:home_challenger_for_flutter/common/common_provider/dio_client.dart';
import 'package:home_challenger_for_flutter/common/common_provider/end_points.dart';

DioClient getDioClient() {
  return DioClient();
}

final homeDataSourceProvider = Provider<HomeDataSource>((ref) {
  final dioClient =
      getDioClient(); // Obtain the DioClient instance from elsewhere
  return IHomeDataSource(dioClient: dioClient);
});

abstract class HomeDataSource {
  Stream<List<TaskModel>> getAllTasks({required String status});
  Stream<List<TaskModel>> getAllTasksInProgress();
  FutureEither deleteTask({required String id});
  Stream<List<CommentModel>?> getAllComment({required String taskId});
  FutureEither createComment({required CommentModel formData});
}

class IHomeDataSource extends HomeDataSource {
  DioClient dioClient;
  IHomeDataSource({required this.dioClient});

  @override
  Stream<List<TaskModel>> getAllTasks({required String status}) {
    List<TaskModel> previousTaskList = [];

    return Stream.periodic(const Duration(milliseconds: 100))
        .asyncMap((_) async {
      try {
        // Fetch the data from the server
        final response = await dioClient.get(
          Endpoints.baseUrl + Endpoints.taskEndPoint,
          options: Options(
            headers: header(authToken: 'Bearer ${Endpoints.apiToken}'),
          ),
        );

        if (response is List) {
          List<TaskModel> taskList = (response)
              .map((json) => TaskModel.fromMap(json as Map<String, dynamic>))
              .toList();

          // Filter tasks based on status
          List<TaskModel> filteredTasks;
          if (status == "In-progress") {
            filteredTasks =
                taskList.where((element) => !element.is_completed!).toList();
          } else {
            filteredTasks = taskList;
          }

          if (_isTaskListChanged(previousTaskList, filteredTasks)) {
            previousTaskList = filteredTasks;
            return filteredTasks;
          } else {
            return previousTaskList; // Emit the previous list to avoid unnecessary updates
          }
        } else {
          throw Exception('Unexpected response type');
        }
      } catch (e) {
        print('Error fetching tasks: $e');
        throw Exception(e);
      }
    }).distinct();
  }

  /// Helper method to check if the task list has changed
  bool _isTaskListChanged(List<TaskModel> oldList, List<TaskModel> newList) {
    if (oldList.length != newList.length) return true;

    for (int i = 0; i < oldList.length; i++) {
      if (oldList[i] != newList[i]) return true;
    }
    return false;
  }

  @override
  Stream<List<TaskModel>> getAllTasksInProgress() {
    List<TaskModel> previousTaskList = [];

    return Stream.periodic(const Duration(milliseconds: 100))
        .asyncMap((_) async {
      try {
        final response = await dioClient.get(
          Endpoints.baseUrl + Endpoints.taskEndPoint,
          options: Options(
            headers: header(authToken: 'Bearer ${Endpoints.apiToken}'),
          ),
        );

        if (response is List) {
          List<TaskModel> taskList = (response)
              .map((json) => TaskModel.fromMap(json as Map<String, dynamic>))
              .toList();

          List<TaskModel> inProgressTasks =
              taskList.where((element) => !element.is_completed!).toList();

          if (_isTaskListChang(previousTaskList, inProgressTasks)) {
            previousTaskList = inProgressTasks;
            return inProgressTasks;
          } else {
            return previousTaskList;
          }
        } else {
          throw Exception('Unexpected response type');
        }
      } catch (e) {
        print('Error fetching tasks: $e');
        throw Exception(e);
      }
    }).distinct();
  }

  bool _isTaskListChang(List<TaskModel> oldList, List<TaskModel> newList) {
    if (oldList.length != newList.length) return true;

    for (int i = 0; i < oldList.length; i++) {
      if (oldList[i] != newList[i]) return true;
    }
    return false;
  }

  // delete task
  @override
  FutureEither<String> deleteTask({required String id}) async {
    try {
      await dioClient.delete(
        '${Endpoints.baseUrl}${Endpoints.taskEndPoint}/$id',
        options: Options(
          headers: header(authToken: 'Bearer ${Endpoints.apiToken}'),
        ),
      );
      return Either.right('success');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<CommentModel>?> getAllComment({required String taskId}) {
    List<CommentModel> previousTaskList = [];

    return Stream.periodic(const Duration(milliseconds: 100))
        .asyncMap((_) async {
      try {
        final response = await dioClient.get(
          '${Endpoints.baseUrl}${Endpoints.commentEndPoint}?task_id=$taskId',
          options: Options(
            headers: header(authToken: 'Bearer ${Endpoints.apiToken}'),
          ),
        );
        if (response is List) {
          List<CommentModel> commentList = (response)
              .map((json) => CommentModel.fromMap(json as Map<String, dynamic>))
              .toList();

          if (_isCommentListChang(previousTaskList, commentList)) {
            previousTaskList = commentList;
            return commentList;
          } else {
            return previousTaskList;
          }
        }
      } catch (e) {
        print('Error fetching tasks: $e');
        return previousTaskList;
      }
    }).distinct();
  }

  bool _isCommentListChang(
      List<CommentModel> oldList, List<CommentModel> newList) {
    if (oldList.length != newList.length) return true;

    for (int i = 0; i < oldList.length; i++) {
      if (oldList[i] != newList[i]) return true;
    }
    return false;
  }

// add comment
  @override
  FutureEither createComment({required CommentModel formData}) async {
    try {
      final response = await dioClient.post(
        Endpoints.baseUrl + Endpoints.commentEndPoint,
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

  // @override
  // Future<List<TaskModel>> getAllTasks({required String status}) async {
  //   try {
  //     final response = await dioClient.get(
  //       Endpoints.baseUrl,
  //       options: Options(
  //         headers: header(authToken: 'Bearer ${Endpoints.apiToken}'),
  //       ),
  //     );
  //     if (response is List) {
  //       List<TaskModel> taskList = (response)
  //           .map((json) => TaskModel.fromMap(json as Map<String, dynamic>))
  //           .toList();

  //       if (status == "In-progress") {
  //         return taskList
  //             .where((element) => element.is_completed == false)
  //             .toList();
  //       } else if (status == "Completed") {
  //         return taskList
  //             .where((element) => element.is_completed == true)
  //             .toList();
  //       } else {
  //         return taskList;
  //       }
  //     }
  //     return [];
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // Future<List<TaskModel>> fetchAllTasksInprogress() async {
  //   try {
  //     final response = await dioClient.get(
  //       Endpoints.baseUrl,
  //       options: Options(
  //         headers: header(authToken: 'Bearer ${Endpoints.apiToken}'),
  //       ),
  //     );
  //     if (response is List) {
  //       List<TaskModel> taskList = (response)
  //           .map((json) => TaskModel.fromMap(json as Map<String, dynamic>))
  //           .toList();

  //       return taskList
  //           .where((element) => element.is_completed == false)
  //           .toList();
  //     }
  //     return [];
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}

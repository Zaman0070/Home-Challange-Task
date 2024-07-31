// ignore_for_file: use_build_context_synchronously
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/show_toast.dart';
import 'package:home_challenger_for_flutter/features/home/data/home_apis.dart';
import 'package:home_challenger_for_flutter/models/comment_model.dart';
import 'package:home_challenger_for_flutter/models/task_model.dart';

final homeControllerProvider =
    StateNotifierProvider<HomeController, bool>((ref) {
  final homeDataSource = ref.read(homeDataSourceProvider);
  return HomeController(homeDataSource);
});

final watchAllTaskProvider =
    StreamProvider.family<List<TaskModel>, String>((ref, status) {
  final homeController = ref.read(homeControllerProvider.notifier);
  return homeController.getAllTasks(status);
});
final watchAllTaskInProgressProvider = StreamProvider<List<TaskModel>>((ref) {
  final favController = ref.watch(homeControllerProvider.notifier);
  return favController.getAllTasksInprogress();
});

final watchAllCommentsProvider =
    StreamProvider.family<List<CommentModel>?, String>((ref, taskId) {
  final homeController = ref.read(homeControllerProvider.notifier);
  return homeController.getAllComments(taskId);
});

class HomeController extends StateNotifier<bool> {
  final HomeDataSource _homeDataSource;

  HomeController(this._homeDataSource) : super(false);

  Stream<List<TaskModel>> getAllTasks(String status) {
    return _homeDataSource.getAllTasks(status: status);
  }

  Stream<List<TaskModel>> getAllTasksInprogress() {
    return _homeDataSource.getAllTasksInProgress();
  }

  // delete task
  Future<void> deleteTask(
      {required String id, required BuildContext context}) async {
    state = true;
    final result = await _homeDataSource.deleteTask(id: id);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      showToast(
          msg: 'Task deleted successfully', backgroundColor: Colors.green);
      Navigator.pop(context);
    });
  }

  // get all comments
  Stream<List<CommentModel>?> getAllComments(String taskId) {
    return _homeDataSource.getAllComment(taskId: taskId);
  }

  // create comment
  Future<void> createComment(
      {required CommentModel formData, required BuildContext context}) async {
    state = true;
    final result = await _homeDataSource.createComment(formData: formData);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showToast(
          msg: 'Comment added successfully', backgroundColor: Colors.green);
    });
  }
}

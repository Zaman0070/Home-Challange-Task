// ignore_for_file: use_build_context_synchronously
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/show_toast.dart';
import 'package:home_challenger_for_flutter/features/home/create_task/data/create_task_apis.dart';
import 'package:home_challenger_for_flutter/models/task_model.dart';

final addTaskControllerProvider =
    StateNotifierProvider<AddTaskController, bool>((ref) {
  final addTaskDataSource = ref.read(createTaskDataSourceProvider);
  return AddTaskController(addTaskDataSource);
});

class AddTaskController extends StateNotifier<bool> {
  final CreateTaskDataSource _addTaskDataSource;

  AddTaskController(this._addTaskDataSource) : super(false);

  Future<void> createTask(
      {required TaskModel formData, required BuildContext context}) async {
    state = true;
    final result = await _addTaskDataSource.createTask(formData: formData);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      showToast(
          msg: 'Task created successfully', backgroundColor: Colors.green);
      Navigator.pop(context);
    });
  }

  Future<void> updateTask(
      {required TaskModel formData, required BuildContext context}) async {
    state = true;
    final result = await _addTaskDataSource.updateTask(formData: formData);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      showToast(
          msg: 'Task updated successfully', backgroundColor: Colors.green);
      Navigator.pop(context);
    });
  }

  Future<void> markAsClose(
      {required String id, required BuildContext context}) async {
    state = true;
    final result = await _addTaskDataSource.markAsClose(id: id);
    result.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      state = false;
      showToast(
        msg: 'Task marked as close successfully, You can see in history',
        backgroundColor: Colors.green,
      );
    });
  }
}

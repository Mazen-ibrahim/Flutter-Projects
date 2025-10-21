import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  final taskList = <Task>[].obs;

  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  Future<void> addTask(Task task) async {
    await DBHelper.insert(task);
    getTasks();
  }

  Future<void> deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  Future<void> markAsCompleted(Task task) async {
    await DBHelper.update(task);
    getTasks();
  }

  Future<void> filterTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    List<Task> allTasks = tasks.map((data) => Task.fromJson(data)).toList();
    DateTime now = DateTime.now();
    for(var task in allTasks) {
      DateTime taskDate = DateTime.parse(task.date!);
      if (taskDate.isBefore(now)) {
        await DBHelper.delete(task);
      }
    }
  }
}

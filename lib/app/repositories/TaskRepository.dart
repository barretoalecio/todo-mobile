import 'package:dio/dio.dart';
import 'package:todo_mobile/app/models/TaskModel.dart';

class TaskRepository {
  final Dio _dio;
  TaskRepository([this._dio]);

  Future<List<TaskModel>> getAllTasks() async {
    final response = await _dio.get('/tasks');
    List<TaskModel> list = [];
    for (final item in (response.data as List)) {
      TaskModel taskModel = new TaskModel(
          id: item['id'],
          title: item['title'],
          complete: item['complete'],
          description: item['description']);
      list.add(taskModel);
    }
    return list;
  }

  Future<TaskModel> updateTask(TaskModel taskModel) async {
    await _dio.put('/tasks/${taskModel.id}', data: {
      "title": taskModel.title,
      "description": taskModel.description,
      "complete": taskModel.complete
    });
  }
  Future deleteTask(String id) async {
    await _dio.delete('/tasks/$id');
  }
  Future createTask(TaskModel taskModel) async {
      final response = await _dio.post('/tasks', data: {
        "title": taskModel.title,
        "description": taskModel.description,
        "complete": taskModel.complete
      });
      return response;
    }
}
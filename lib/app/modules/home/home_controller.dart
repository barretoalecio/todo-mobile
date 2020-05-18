import 'package:mobx/mobx.dart';
import 'package:todo_mobile/app/models/TaskModel.dart';
import 'package:todo_mobile/app/repositories/TaskRepository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final TaskRepository _taskRepository;

  @observable
  ObservableFuture<List<TaskModel>> tasks;

  _HomeControllerBase([this._taskRepository]) {
    fetchTasks();
  }

  @action
  void fetchTasks() {
    this.tasks = _taskRepository.getAllTasks().asObservable();
  }

  @action
  void postTask(TaskModel taskModel) {
    _taskRepository.createTask(taskModel);
  }

  @action
  void deleteTask(TaskModel taskModel) {
    _taskRepository.deleteTask(taskModel.id);
  }

  @action
  void updateTask(TaskModel taskModel) {
    _taskRepository.updateTask(taskModel);
  }
}

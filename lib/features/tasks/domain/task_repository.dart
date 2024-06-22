import 'package:taskmanager/features/tasks/data/datasources/local_datasource.dart';
import 'package:taskmanager/features/tasks/data/models/task_model.dart';

 class TaskRepository {
  final LocalDataSource localDataSource = LocalDataSource();
  Future<List<TaskModel>> getTasks()async{
    return localDataSource.getTasks().map(TaskModel.fromJson).toList();
  }
  TaskModel getTask(int id){
    return TaskModel.fromJson(localDataSource.getTasks().firstWhere((element) => TaskModel.fromJson(element).id == id));
  }
  Future<void> addTask(TaskModel data)async{
    final task = data.copyWith(id: localDataSource.boxLength);
   await localDataSource.addTask(task.toJson());
  }
  Future<void> updateTask(TaskModel task)async{
   await localDataSource.updateTask(localDataSource.getTasks().indexWhere((element) => TaskModel.fromJson(element).id == task.id), task.toJson());
  }
  Future<void> deleteTask(int id)async{
    await localDataSource.deleteTask(localDataSource.getTasks().indexWhere((element) => TaskModel.fromJson(element).id == id));
  }

  Future<void> clearTasks()async{
     localDataSource.clearTasks();
  }
    }
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager/features/tasks/data/models/task_model.dart';
import 'package:taskmanager/features/tasks/domain/task_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit
  (
    this.repository,
  ) : super(TasksInitial());
  final TaskRepository repository;

  Future<void> getTasks() async {
    emit(TasksLoading());
    try {
      final tasks = await repository.getTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> addTask(TaskModel task) async {
    emit(TasksLoading());
    try {
      await repository.addTask(task);
      emit(TaskAdded());
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> updateTask(TaskModel task) async {
    emit(TasksLoading());
    try {
      await repository.updateTask(task);
      emit(TaskUpdated());
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> deleteTask(int id) async {
    emit(TasksLoading());
    try {
      await repository.deleteTask(id);
      emit(TaskDeleted());
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> clearTasks() async {
    emit(TasksLoading());
    try {
      await repository.clearTasks();
      emit(TaskCleared());
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }
  
}

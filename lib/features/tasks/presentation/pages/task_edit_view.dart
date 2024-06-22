import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/app/configs/configs.dart';
import 'package:taskmanager/features/tasks/data/models/task_model.dart';
import 'package:taskmanager/features/tasks/presentation/cubit/tasks_cubit.dart';

class TaskEditView extends StatefulWidget {
const TaskEditView({required this.id, super.key });
final String id;

  @override
  State<TaskEditView> createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: BlocListener<TasksCubit, TasksState>(
        listener: (context, state) {
          if (state is TaskUpdated) {
            context.read<TasksCubit>().getTasks();
            context.replace('/');
          }
          if(state is TasksError){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
               Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                                      style:  const TextStyle(height: 1.5, color: Palette.primary),

                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                                      style:  const TextStyle(height: 1.5, color: Palette.primary),

                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    // Update Task
                    if (_formKey.currentState!.validate()) {
                      context.read<TasksCubit>().updateTask(
                        TaskModel(
                          id: int.parse(widget.id),
                          title: _titleController.text,
                          description: _descriptionController.text,
                          isCompleted: false,
                        ),
                      );
                    }
                  },
                  child: const Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
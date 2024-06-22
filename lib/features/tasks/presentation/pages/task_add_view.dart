import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/app/configs/configs.dart';
import 'package:taskmanager/features/tasks/data/models/task_model.dart';
import 'package:taskmanager/features/tasks/presentation/cubit/tasks_cubit.dart';

class TaskAddView extends StatefulWidget {
const TaskAddView({ super.key });

  @override
  State<TaskAddView> createState() => _TaskAddViewState();
}

class _TaskAddViewState extends State<TaskAddView> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Tasks'),
      ),
      body: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          if (state is TaskAdded) {
            context.read<TasksCubit>().getTasks();
            context.replace('/');
          }
          if (state is TasksError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
              context.read<TasksCubit>().getTasks();
            context.replace('/');
          }
        },
        builder: (context, state) {

          return Form(
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
                    onPressed:  () {
                      // Add Task
                      if (_formKey.currentState!.validate()) {
                        final title = _titleController.text;
                        final description = _descriptionController.text;
                        final task = TaskModel(
                          title: title,
                          description: description,
                          isCompleted: false,
                        );
                        context.read<TasksCubit>().addTask(task);
                      }
                    },
                    child: const Text('Add Task'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
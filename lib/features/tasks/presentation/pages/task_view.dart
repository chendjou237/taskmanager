import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/app/utils/extensions.dart';
import 'package:taskmanager/features/tasks/presentation/cubit/tasks_cubit.dart';

class TaskView extends StatefulWidget {
  
const TaskView({required this.id,  super.key });
final String id ;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task View'),
      ),
      body: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          if (state is TaskDeleted) {
            context.read<TasksCubit>().getTasks();
            context.go('/');
          }
        },
        builder: (context, state) {
if (state is TasksLoaded) {
  final task = state.tasks.firstWhere((element) => element.id ==  int.parse(widget.id));
  return Column(
    children: [
      ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
      ),
      16.vGap,
      ElevatedButton(
        onPressed: () {
          context.go('/edit/${task.id}');
        },
        child: const Text('Edit'),
      ),
      8.vGap,
      ElevatedButton(
        onPressed: () {
          context.read<TasksCubit>().deleteTask(task.id!);
        },
        child: const Text('Delete'),
      ),
    ],
  );
}
return const Center(child: CircularProgressIndicator.adaptive());
         
        },
      ),
    );
  }
}

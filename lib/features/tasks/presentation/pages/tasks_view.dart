import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/features/tasks/presentation/cubit/tasks_cubit.dart';

class TasksView extends StatelessWidget {
const TasksView({ super.key });

  @override
  Widget build(BuildContext context){
    return BlocConsumer<TasksCubit, TasksState>(

      listener: (context, state) {
        if (state is TasksError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
if(state is TaskCleared){
  context.read<TasksCubit>().getTasks();
}
      },
      builder: (context, state) {
        return Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<TasksCubit>().getTasks();
              },
            ),
            
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<TasksCubit>().clearTasks();
              },
            ),
      
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go('/add');
          },
          child: const Icon(Icons.add),
        ),
        body:
             SingleChildScrollView(
              child: Column(
                children: [
                  if (state is TasksLoading) ...[
                    const Center(child: CircularProgressIndicator.adaptive()),
                  ],
      
                  
                  if (state is TasksLoaded) ...[
                    if(state.tasks.isEmpty ) ...[
                      const Text('No tasks found'),
                    ] else 
                    for (final task in state.tasks) ...[
                      GestureDetector(
                        onTap: () {
                        context.go('/${task.id}');
                        },
                        child: ListTile(
                          title: Text(task.title),
                          subtitle: Text(task.description),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ] ,
                  ],
                  if (state is TasksError) ...[
                    Text(state.message),
                  ],
                ],
              )));
            
          
        
      
      },
    );
  }
}
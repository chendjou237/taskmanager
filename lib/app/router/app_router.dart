import 'package:go_router/go_router.dart';
import 'package:taskmanager/features/tasks/presentation/pages/pages.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TasksView(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const TaskAddView(),
    ),
    GoRoute(
      path: '/edit/:id',
      builder: (context, state) =>  TaskEditView( id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/:id',
      builder: (context, state) =>  TaskView(id: state.pathParameters['id']!,),
    ),
  ],
);
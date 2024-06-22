import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/app/configs/app_theme.dart';
import 'package:taskmanager/app/router/app_router.dart';
import 'package:taskmanager/features/tasks/domain/task_repository.dart';
import 'package:taskmanager/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:taskmanager/l10n/l10n.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
        const theme = TaskTheme();

    return RepositoryProvider(
      create: (context) => TaskRepository(),
      child: BlocProvider(
        create: (context) => TasksCubit(context.read<TaskRepository>())..getTasks(),
        child: MaterialApp.router(
          routerConfig: router,
              theme: theme.toThemeData(Brightness.light),
              darkTheme: theme.toThemeData(
                Brightness.dark,
              ),
                            debugShowCheckedModeBanner: false,

          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}

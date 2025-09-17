import 'package:flutter_application_2/provider/task_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/task_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepository(getIt<SharedPreferences>()),
  );

  getIt.registerFactory<TaskProvider>(
    () => TaskProvider(getIt<TaskRepository>()),
  );

  await getIt.allReady();
}

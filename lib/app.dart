import 'package:flutter/material.dart';
import 'package:flutter_application_2/di/get_it.dart';
import 'package:flutter_application_2/presentation/page/home_page.dart';
import 'package:flutter_application_2/provider/task_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: ChangeNotifierProvider(
        create: (_) => getIt<TaskProvider>()..init(),
        child: const HomePage(),
      ),
    );
  }
}

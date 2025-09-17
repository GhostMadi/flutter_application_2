import 'package:flutter/material.dart';
import 'package:flutter_application_2/app.dart';
import 'package:flutter_application_2/di/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  runApp(const MyApp());
}

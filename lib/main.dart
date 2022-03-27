import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/app/main_widget/app_module.dart';
import 'package:todo_list/src/app/main_widget/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

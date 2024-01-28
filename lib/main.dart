import 'package:MyEmployee/modules/employee/models/emp_model.dart';
import 'package:MyEmployee/modules/employee/ui/emp_list.dart';
import 'package:MyEmployee/services/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    var appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
  }
  Hive.registerAdapter(EmployeeModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Employee',
        theme: AppTheme.appTheme,
        home: const MyEmployeeListPage());
  }
}

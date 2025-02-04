import 'package:flutter/material.dart';
import 'pages/employee_list_page.dart';
import 'theme/app_theme.dart';
import 'services/hive_service.dart';
import 'providers/bloc_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  runApp(
    const AppBlocProvider(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management',
      theme: AppTheme.theme,
      home: const EmployeeListPage(),
    );
  }
}

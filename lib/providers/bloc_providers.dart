import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_management/bloc/employee/employee_bloc.dart';
import 'package:employee_management/services/hive_service.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmployeeBloc(
            hiveService: HiveService(),
          )..add(LoadEmployees()),
        ),
      ],
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/employee/employee_bloc.dart';
import '../cubit/add_employee/add_employee_cubit.dart';
import '../services/hive_service.dart';

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
        BlocProvider<EmployeeBloc>(
          create: (context) => EmployeeBloc(
            hiveService: HiveService(),
          )..add(const LoadEmployees()),
        ),
      ],
      child: child,
    );
  }
}

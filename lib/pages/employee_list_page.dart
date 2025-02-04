import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/employee/employee_bloc.dart';
import 'add_employee_page.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EmployeeError) {
            return Center(child: Text(state.message));
          }

          if (state is EmployeeLoaded && state.employees.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/no_employees.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No employee records found',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }

          if (state is EmployeeLoaded) {
            final currentEmployees = state.employees
                .where((employee) => employee.endDate == null)
                .toList();
            final previousEmployees = state.employees
                .where((employee) => employee.endDate != null)
                .toList();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (currentEmployees.isNotEmpty) ...[
                  const Text(
                    'Current employees',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...currentEmployees.map((employee) => Card(
                        child: ListTile(
                          title: Text(employee.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(employee.position),
                              Text('From ${employee.startDate}'),
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(height: 24),
                ],
                if (previousEmployees.isNotEmpty) ...[
                  const Text(
                    'Previous employees',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...previousEmployees.map((employee) => Card(
                        child: ListTile(
                          title: Text(employee.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(employee.position),
                              Text(
                                  '${employee.startDate} - ${employee.endDate}'),
                            ],
                          ),
                        ),
                      )),
                ],
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEmployeePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

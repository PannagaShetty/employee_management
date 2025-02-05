import 'package:employee_management/bloc/add_employee/add_employee_bloc.dart';
import 'package:employee_management/bloc/employee/employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'add_employee_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee List',
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EmployeeError) {
            return Center(child: Text(state.message));
          }

          if (state is EmployeeLoaded) {
            if (state.employees.isEmpty) {
              return _buildEmptyState();
            }

            final currentEmployees = state.employees
                .where((employee) =>
                    DateTime.parse(employee.endDate).isAfter(DateTime.now()))
                .toList();
            final previousEmployees = state.employees
                .where((employee) =>
                    DateTime.parse(employee.endDate).isBefore(DateTime.now()))
                .toList();

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      if (currentEmployees.isNotEmpty)
                        _buildCurrentEmployeesSection(currentEmployees),
                      if (previousEmployees.isNotEmpty)
                        _buildPreviousEmployeesSection(previousEmployees),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Swipe left to delete',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
              builder: (context) => BlocProvider(
                create: (context) => AddEmployeeBloc(
                  employeeBloc: context.read<EmployeeBloc>(),
                ),
                child: const AddEmployeePage(),
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/not_found.svg',
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

  Widget _buildCurrentEmployeesSection(List<dynamic> currentEmployees) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey[100],
          padding: const EdgeInsets.all(16),
          child: const Row(
            children: [
              Text(
                'Current employees',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        ...currentEmployees.map((employee) => Builder(
              builder: (context) => Dismissible(
                key: Key(employee.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: const Color(0xFFFF4444),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                onDismissed: (direction) {
                  context.read<EmployeeBloc>().add(DeleteEmployee(employee.id));
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          employee.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          employee.role.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'From ${DateFormat('d MMM, y').format(DateTime.parse(employee.fromDate))}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildPreviousEmployeesSection(List<dynamic> previousEmployees) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey[100],
          padding: const EdgeInsets.all(16),
          child: const Row(
            children: [
              Text(
                'Previous employees',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        ...previousEmployees.map((employee) => Builder(
              builder: (context) => Dismissible(
                key: Key(employee.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: const Color(0xFFFF4444),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                onDismissed: (direction) {
                  context.read<EmployeeBloc>().add(DeleteEmployee(employee.id));
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          employee.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          employee.role.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${DateFormat('d MMM, y').format(DateTime.parse(employee.fromDate))} - ${DateFormat('d MMM, y').format(DateTime.parse(employee.endDate))}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

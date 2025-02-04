import 'package:employee_management/bloc/employee/employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/add_employee/add_employee_cubit.dart';
import '../cubit/add_employee/add_employee_state.dart';
import '../models/employee.dart';
import '../widgets/custom_snackbar.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEmployeeCubit(
        employeeBloc: context.read<EmployeeBloc>(),
      ),
      // This ensures the cubit is disposed when the page is popped
      child: const _AddEmployeeView(),
    );
  }
}

class _AddEmployeeView extends StatefulWidget {
  const _AddEmployeeView();

  @override
  State<_AddEmployeeView> createState() => _AddEmployeeViewState();
}

class _AddEmployeeViewState extends State<_AddEmployeeView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showRoleBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        shrinkWrap: true,
        itemCount: Role.values.length,
        itemBuilder: (context, index) {
          final role = Role.values[index];
          return ListTile(
            title: Text(role.toString()),
            onTap: () {
              context.read<AddEmployeeCubit>().updateRole(role);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  Future<void> _selectDate(bool isStartDate) async {
    final today = DateTime.now();
    final state = context.read<AddEmployeeCubit>().state;

    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Quick select buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _quickSelectButton(
                      isStartDate ? 'Today' : 'No date',
                      isStartDate ? today : null,
                    ),
                  ),
                  Expanded(
                    child: _quickSelectButton(
                      'Next Monday',
                      _getNextWeekday(today, DateTime.monday),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _quickSelectButton(
                      'Next Tuesday',
                      _getNextWeekday(today, DateTime.tuesday),
                    ),
                  ),
                  Expanded(
                    child: _quickSelectButton(
                      'After 1 week',
                      today.add(const Duration(days: 7)),
                    ),
                  ),
                ],
              ),
              // Calendar
              CalendarDatePicker(
                initialDate: isStartDate ? today : (state.startDate ?? today),
                firstDate:
                    isStartDate ? DateTime(2000) : (state.startDate ?? today),
                lastDate: DateTime(2100),
                onDateChanged: (DateTime date) {
                  Navigator.pop(context, date);
                },
                selectableDayPredicate: isStartDate
                    ? null
                    : (DateTime date) {
                        return date.isAfter(state.startDate
                                ?.subtract(const Duration(days: 1)) ??
                            today);
                      },
              ),
              // Bottom buttons
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, today),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    if (picked != null) {
      if (isStartDate) {
        context.read<AddEmployeeCubit>().updateStartDate(picked);
      } else {
        context.read<AddEmployeeCubit>().updateEndDate(picked);
      }
    }
  }

  Widget _quickSelectButton(String text, DateTime? date) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          side: const BorderSide(color: Colors.blue),
        ),
        onPressed: () => Navigator.pop(context, date),
        child: Text(text),
      ),
    );
  }

  DateTime _getNextWeekday(DateTime from, int weekday) {
    DateTime date = from;
    while (date.weekday != weekday) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEmployeeCubit, AddEmployeeState>(
      listener: (context, state) {
        if (state.error != null) {
          CustomSnackBar.show(
            context,
            message: state.error!,
            isError: true,
          );
          context.read<AddEmployeeCubit>().resetError();
        }
        if (state.isSuccess) {
          CustomSnackBar.show(
            context,
            message: 'Employee added successfully',
            actionLabel: 'UNDO',
            onActionPressed: () {
              // Handle undo action
            },
          );
          context.read<AddEmployeeCubit>().resetSuccess();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Employee Details'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          onChanged: (value) {
                            context.read<AddEmployeeCubit>().updateName(value);
                          },
                          decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.person_outline, color: Colors.blue),
                            border: OutlineInputBorder(),
                            hintText: 'Employee name',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Role selection
                        TextFormField(
                          readOnly: true,
                          onTap: _showRoleBottomSheet,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.work_outline,
                                color: Colors.blue),
                            border: const OutlineInputBorder(),
                            hintText: 'Select role',
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            hintStyle: state.selectedRole == null
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.grey)
                                : null,
                          ),
                          controller: TextEditingController(
                            text: state.selectedRole?.toString() ?? '',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Date selection
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                onTap: () => _selectDate(true),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_today,
                                      color: Colors.blue),
                                  border: OutlineInputBorder(),
                                  hintText: 'Today',
                                ),
                                controller: TextEditingController(
                                  text: state.startDate != null
                                      ? _formatDate(state.startDate!)
                                      : 'Today',
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child:
                                  Icon(Icons.arrow_forward, color: Colors.blue),
                            ),
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                onTap: () => _selectDate(false),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_today,
                                      color: Colors.blue),
                                  border: OutlineInputBorder(),
                                  hintText: 'No date',
                                ),
                                controller: TextEditingController(
                                  text: state.endDate != null
                                      ? _formatDate(state.endDate!)
                                      : 'No date',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AddEmployeeCubit>().submitForm();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:employee_management/models/employee.dart';
import 'package:employee_management/widgets/custom_button.dart';
import 'package:employee_management/widgets/custom_snackbar.dart';
import 'package:employee_management/bloc/add_employee/add_employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    context.read<AddEmployeeBloc>().add(UpdateStartDateEvent(DateTime.now()));
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showRoleBottomSheet() {
    final bloc = context.read<AddEmployeeBloc>();
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.separated(
        shrinkWrap: true,
        itemCount: Role.values.length,
        separatorBuilder: (context, index) => const Divider(
          thickness: 0.5,
        ),
        itemBuilder: (context, index) {
          final role = Role.values[index];
          return ListTile(
            title: Center(child: Text(role.toString())),
            onTap: () {
              bloc.add(UpdateRoleEvent(role));
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  Future<void> _selectDate(bool isStartDate, DateTime? initialDate,
      AddEmployeeState state, BuildContext context) async {
    final today = DateTime.now();
    final bloc = context.read<AddEmployeeBloc>();
    bloc.add(UpdateTempDateEvent(initialDate));

    await showDialog<DateTime>(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<AddEmployeeBloc, AddEmployeeState>(
            builder: (context, dialogState) {
              final currentState = dialogState as AddEmployeeInitial;
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _quickSelectButton(
                            isStartDate ? 'Today' : 'No date',
                            isStartDate ? today : null,
                            currentState.tempSelectedDate,
                          ),
                        ),
                        Expanded(
                          child: _quickSelectButton(
                            'Next Monday',
                            _getNextWeekday(today, DateTime.monday),
                            currentState.tempSelectedDate,
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
                            currentState.tempSelectedDate,
                          ),
                        ),
                        Expanded(
                          child: _quickSelectButton(
                            'After 1 week',
                            today.add(const Duration(days: 7)),
                            currentState.tempSelectedDate,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 300,
                      child: CalendarDatePicker(
                        key: ValueKey(
                            '${currentState.tempSelectedDate?.millisecondsSinceEpoch}'),
                        initialDate: !isStartDate
                            ? (currentState.tempSelectedDate ??
                                        currentState.startDate!)
                                    .isAfter(currentState.startDate!)
                                ? currentState.tempSelectedDate ??
                                    currentState.startDate!
                                : currentState.startDate!
                            : currentState.tempSelectedDate ?? today,
                        firstDate: isStartDate
                            ? DateTime(2000)
                            : currentState.startDate!,
                        lastDate: DateTime(2100),
                        currentDate: currentState.tempSelectedDate ?? today,
                        onDateChanged: (DateTime date) {
                          bloc.add(UpdateTempDateEvent(date));
                        },
                        selectableDayPredicate: isStartDate
                            ? null
                            : (DateTime date) {
                                return date.isAfter(currentState.startDate!
                                    .subtract(const Duration(days: 1)));
                              },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            onPressed: () {
                              bloc.add(ClearTempDateEvent());
                              Navigator.pop(dialogContext);
                            },
                            text: 'Cancel',
                            isPrimary: false,
                          ),
                          const SizedBox(width: 8),
                          CustomButton(
                            onPressed: () {
                              final tempDate = currentState.tempSelectedDate;
                              if (tempDate != null) {
                                if (isStartDate) {
                                  bloc.add(UpdateStartDateEvent(tempDate));
                                } else {
                                  bloc.add(UpdateEndDateEvent(tempDate));
                                }
                              }
                              bloc.add(ClearTempDateEvent());
                              Navigator.pop(dialogContext);
                            },
                            text: 'Save',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _quickSelectButton(
      String text, DateTime? date, DateTime? initialDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomButton(
        text: text,
        onPressed: () {
          context.read<AddEmployeeBloc>().add(UpdateTempDateEvent(date));
        },
        isPrimary: (initialDate != null &&
                date?.year == initialDate.year &&
                date?.month == initialDate.month &&
                date?.day == initialDate.day) ||
            (initialDate == null && date == null),
        fixedSize: const Size(double.infinity, 44),
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
    return BlocConsumer<AddEmployeeBloc, AddEmployeeState>(
      listener: (context, state) {
        if (state is AddEmployeeSuccess) {
          CustomSnackBar.show(
            context,
            message: 'Employee added successfully',
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final employeeState = state is AddEmployeeInitial
            ? state
            : AddEmployeeInitial(startDate: DateTime.now());

        _nameController.text = employeeState.name ?? '';
        _nameController.selection = TextSelection.fromPosition(
          TextPosition(offset: employeeState.name?.length ?? 0),
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Employee Details'),
            automaticallyImplyLeading: false,
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
                            context
                                .read<AddEmployeeBloc>()
                                .add(UpdateNameEvent(value));
                          },
                          decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.person_outline, color: Colors.blue),
                            border: OutlineInputBorder(),
                            hintText: 'Employee name',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          readOnly: true,
                          onTap: _showRoleBottomSheet,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.work_outline,
                                color: Colors.blue),
                            border: const OutlineInputBorder(),
                            hintText: 'Select role',
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            hintStyle: employeeState.selectedRole == null
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.grey)
                                : null,
                          ),
                          controller: TextEditingController(
                            text: employeeState.selectedRole?.toString() ?? '',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                onTap: () async {
                                  await _selectDate(
                                      true,
                                      employeeState.startDate,
                                      employeeState,
                                      context);
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_today,
                                      color: Colors.blue),
                                  border: OutlineInputBorder(),
                                  hintText: 'Today',
                                ),
                                controller: TextEditingController(
                                  text: employeeState.startDate != null
                                      ? _formatDate(employeeState.startDate!)
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
                                onTap: () async {
                                  await _selectDate(
                                      false,
                                      employeeState.endDate,
                                      employeeState,
                                      context);
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_today,
                                      color: Colors.blue),
                                  border: OutlineInputBorder(),
                                  hintText: 'No date',
                                ),
                                controller: TextEditingController(
                                  text: employeeState.endDate != null
                                      ? _formatDate(employeeState.endDate!)
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
                    CustomButton(
                      onPressed: () => Navigator.pop(context),
                      text: 'Cancel',
                      isPrimary: false,
                    ),
                    const SizedBox(width: 16),
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<AddEmployeeBloc>()
                              .add(SubmitFormEvent());
                        }
                      },
                      text: 'Save',
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

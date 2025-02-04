import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../models/employee.dart';
import '../../bloc/employee/employee_bloc.dart';
import 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  final EmployeeBloc employeeBloc;

  AddEmployeeCubit({required this.employeeBloc})
      : super(AddEmployeeState(startDate: DateTime.now()));

  void resetState() {
    emit(AddEmployeeState(startDate: DateTime.now()));
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateRole(Role? role) {
    emit(state.copyWith(selectedRole: role));
  }

  void updateStartDate(DateTime? date) {
    if (date != null) {
      final endDate = state.endDate;
      emit(state.copyWith(
        startDate: date,
        // Reset end date if it's before the new start date
        endDate: endDate != null && endDate.isBefore(date) ? null : endDate,
      ));
    }
  }

  void updateEndDate(DateTime? date) {
    emit(state.copyWith(endDate: date));
  }

  void submitForm() {
    if (state.name.isEmpty) {
      emit(state.copyWith(error: 'Please enter employee name'));
      return;
    }

    if (state.selectedRole == null) {
      emit(state.copyWith(error: 'Please select a role'));
      return;
    }

    if (state.startDate == null) {
      emit(state.copyWith(error: 'Please select a start date'));
      return;
    }

    try {
      employeeBloc.add(
        AddEmployee(
          Employee(
            id: const Uuid().v4(),
            name: state.name,
            role: state.selectedRole!,
            fromDate: state.startDate!.toIso8601String(),
            endDate: state.endDate?.toIso8601String() ?? '',
          ),
        ),
      );
      emit(state.copyWith(isSuccess: true, error: null));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to add employee'));
    }
  }

  void resetError() {
    emit(state.copyWith(error: null));
  }

  void resetSuccess() {
    emit(state.copyWith(isSuccess: false));
  }
}

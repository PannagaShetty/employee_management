import 'package:employee_management/bloc/employee/employee_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:employee_management/models/employee.dart';
import 'package:equatable/equatable.dart';

part 'add_employee_event.dart';
part 'add_employee_state.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  final EmployeeBloc employeeBloc;

  AddEmployeeBloc({required this.employeeBloc})
      : super(const AddEmployeeInitial()) {
    on<UpdateNameEvent>(_onUpdateName);
    on<UpdateRoleEvent>(_onUpdateRole);
    on<UpdateStartDateEvent>(_onUpdateStartDate);
    on<UpdateEndDateEvent>(_onUpdateEndDate);
    on<UpdateTempDateEvent>(_onUpdateTempDate);
    on<ClearTempDateEvent>(_onClearTempDate);
    on<SubmitFormEvent>(_onSubmitForm);
  }

  void _onUpdateName(UpdateNameEvent event, Emitter<AddEmployeeState> emit) {
    if (state is AddEmployeeInitial) {
      final currentState = state as AddEmployeeInitial;
      emit(currentState.copyWith(name: event.name));
    }
  }

  void _onUpdateRole(UpdateRoleEvent event, Emitter<AddEmployeeState> emit) {
    if (state is AddEmployeeInitial) {
      final currentState = state as AddEmployeeInitial;
      emit(currentState.copyWith(selectedRole: event.role));
    }
  }

  void _onUpdateStartDate(
      UpdateStartDateEvent event, Emitter<AddEmployeeState> emit) {
    if (state is AddEmployeeInitial) {
      final currentState = state as AddEmployeeInitial;
      emit(currentState.copyWith(
        startDate: event.date,
        endDate: null,
      ));
    }
  }

  void _onUpdateEndDate(
      UpdateEndDateEvent event, Emitter<AddEmployeeState> emit) {
    if (state is AddEmployeeInitial) {
      final currentState = state as AddEmployeeInitial;
      emit(currentState.copyWith(
        endDate: event.date,
      ));
    }
  }

  void _onUpdateTempDate(
      UpdateTempDateEvent event, Emitter<AddEmployeeState> emit) {
    if (state is AddEmployeeInitial) {
      final currentState = state as AddEmployeeInitial;
      emit(currentState.copyWith(tempSelectedDate: event.date));
    }
  }

  void _onClearTempDate(
      ClearTempDateEvent event, Emitter<AddEmployeeState> emit) {
    if (state is AddEmployeeInitial) {
      final currentState = state as AddEmployeeInitial;
      emit(currentState.copyWith(
        tempSelectedDate: null,
      ));
    }
  }

  void _onSubmitForm(SubmitFormEvent event, Emitter<AddEmployeeState> emit) {
    if (state is AddEmployeeInitial) {
      final currentState = state as AddEmployeeInitial;

      if (currentState.name?.isEmpty ?? true) {
        emit(const AddEmployeeFailure('Please enter employee name'));
        return;
      }

      if (currentState.selectedRole == null) {
        emit(const AddEmployeeFailure('Please select a role'));
        return;
      }

      try {
        final employee = Employee(
          id: const Uuid().v4(),
          name: currentState.name!,
          role: currentState.selectedRole!,
          fromDate: currentState.startDate?.toIso8601String() ??
              DateTime.now().toIso8601String(),
          endDate: currentState.endDate?.toIso8601String() ?? '',
        );

        employeeBloc.add(AddEmployee(employee));
        emit(const AddEmployeeSuccess());
      } catch (e) {
        emit(const AddEmployeeFailure('Failed to add employee'));
      }
    }
  }
}

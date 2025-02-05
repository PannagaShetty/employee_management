import 'package:employee_management/models/employee.dart';
import 'package:employee_management/services/hive_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final HiveService _hiveService;

  EmployeeBloc({required HiveService hiveService})
      : _hiveService = hiveService,
        super(const EmployeeInitial()) {
    on<LoadEmployees>(_onLoadEmployees);
    on<AddEmployee>(_onAddEmployee);
    on<DeleteEmployee>(_onDeleteEmployee);
  }

  Future<void> _onLoadEmployees(
    LoadEmployees event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(const EmployeeLoading());
    try {
      final employees = await _hiveService.getAllEmployees();
      emit(EmployeeLoaded(employees));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  Future<void> _onAddEmployee(
    AddEmployee event,
    Emitter<EmployeeState> emit,
  ) async {
    final state = this.state;
    if (state is EmployeeLoaded) {
      try {
        await _hiveService.addEmployee(event.employee);
        final updatedEmployees = await _hiveService.getAllEmployees();
        emit(EmployeeLoaded(updatedEmployees));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    }
  }

  Future<void> _onDeleteEmployee(
    DeleteEmployee event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      await _hiveService.deleteEmployee(event.id);
      final employees = await _hiveService.getAllEmployees();
      emit(EmployeeLoaded(employees));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }
}

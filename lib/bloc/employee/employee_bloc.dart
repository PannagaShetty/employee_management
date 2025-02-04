import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/employee.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(const EmployeeInitial()) {
    on<LoadEmployees>(_onLoadEmployees);
    on<AddEmployee>(_onAddEmployee);
    on<UpdateEmployee>(_onUpdateEmployee);
    on<DeleteEmployee>(_onDeleteEmployee);
  }

  Future<void> _onLoadEmployees(
    LoadEmployees event,
    Emitter<EmployeeState> emit,
  ) async {
    emit(const EmployeeLoading());
    try {
      // TODO: Implement loading employees
      emit(const EmployeeLoaded([]));
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
        final List<Employee> updatedEmployees = List.from(state.employees)
          ..add(event.employee);
        emit(EmployeeLoaded(updatedEmployees));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateEmployee(
    UpdateEmployee event,
    Emitter<EmployeeState> emit,
  ) async {
    final state = this.state;
    if (state is EmployeeLoaded) {
      try {
        final List<Employee> updatedEmployees = state.employees.map((employee) {
          return employee.id == event.employee.id ? event.employee : employee;
        }).toList();
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
    final state = this.state;
    if (state is EmployeeLoaded) {
      try {
        final List<Employee> updatedEmployees = state.employees
            .where((employee) => employee.id != event.employeeId)
            .toList();
        emit(EmployeeLoaded(updatedEmployees));
      } catch (e) {
        emit(EmployeeError(e.toString()));
      }
    }
  }
}

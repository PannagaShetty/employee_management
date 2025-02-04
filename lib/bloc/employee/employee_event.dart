part of 'employee_bloc.dart';

sealed class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

final class LoadEmployees extends EmployeeEvent {
  const LoadEmployees();
}

final class AddEmployee extends EmployeeEvent {
  final Employee employee;

  const AddEmployee(this.employee);

  @override
  List<Object> get props => [employee];
}

final class UpdateEmployee extends EmployeeEvent {
  final Employee employee;

  const UpdateEmployee(this.employee);

  @override
  List<Object> get props => [employee];
}

final class DeleteEmployee extends EmployeeEvent {
  final String employeeId;

  const DeleteEmployee(this.employeeId);

  @override
  List<Object> get props => [employeeId];
}

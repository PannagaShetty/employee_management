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

final class DeleteEmployee extends EmployeeEvent {
  final String id;

  const DeleteEmployee(this.id);

  @override
  List<Object> get props => [id];
}

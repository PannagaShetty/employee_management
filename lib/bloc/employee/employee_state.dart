part of 'employee_bloc.dart';

sealed class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

final class EmployeeInitial extends EmployeeState {
  const EmployeeInitial();
}

final class EmployeeLoading extends EmployeeState {
  const EmployeeLoading();
}

final class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;

  const EmployeeLoaded(this.employees);

  @override
  List<Object> get props => [employees];
}

final class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError(this.message);

  @override
  List<Object> get props => [message];
}

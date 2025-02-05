part of 'add_employee_bloc.dart';

sealed class AddEmployeeEvent extends Equatable {
  const AddEmployeeEvent();

  @override
  List<Object?> get props => [];
}

class UpdateNameEvent extends AddEmployeeEvent {
  final String name;

  const UpdateNameEvent(this.name);

  @override
  List<Object> get props => [name];
}

class UpdateRoleEvent extends AddEmployeeEvent {
  final Role? role;

  const UpdateRoleEvent(this.role);

  @override
  List<Object?> get props => [role];
}

class UpdateStartDateEvent extends AddEmployeeEvent {
  final DateTime date;

  const UpdateStartDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class UpdateEndDateEvent extends AddEmployeeEvent {
  final DateTime? date;

  const UpdateEndDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class UpdateTempDateEvent extends AddEmployeeEvent {
  final DateTime? date;

  const UpdateTempDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class ClearTempDateEvent extends AddEmployeeEvent {}

class SubmitFormEvent extends AddEmployeeEvent {}

class ResetErrorEvent extends AddEmployeeEvent {}

class ResetSuccessEvent extends AddEmployeeEvent {}

class ResetStateEvent extends AddEmployeeEvent {}

class StartDatePickerEvent extends AddEmployeeEvent {}

class EndDatePickerEvent extends AddEmployeeEvent {}

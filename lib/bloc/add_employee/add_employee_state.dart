part of 'add_employee_bloc.dart';

sealed class AddEmployeeState extends Equatable {
  const AddEmployeeState();

  @override
  List<Object?> get props => [];
}

class AddEmployeeInitial extends AddEmployeeState {
  final String? name;
  final Role? selectedRole;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? tempSelectedDate;
  final bool isDatePickerVisible;
  final bool isStartDatePicker;

  const AddEmployeeInitial({
    this.name,
    this.selectedRole,
    this.startDate,
    this.endDate,
    this.tempSelectedDate,
    this.isDatePickerVisible = false,
    this.isStartDatePicker = true,
  });

  AddEmployeeInitial copyWith({
    String? name,
    Role? selectedRole,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? tempSelectedDate,
  }) {
    return AddEmployeeInitial(
      name: name ?? this.name,
      selectedRole: selectedRole ?? this.selectedRole,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      tempSelectedDate: tempSelectedDate,
    );
  }

  @override
  List<Object?> get props => [
        name,
        selectedRole,
        startDate,
        endDate,
        tempSelectedDate,
        isDatePickerVisible,
        isStartDatePicker,
      ];
}

class AddEmployeeFailure extends AddEmployeeState {
  final String message;

  const AddEmployeeFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class AddEmployeeSuccess extends AddEmployeeState {
  const AddEmployeeSuccess();
}
